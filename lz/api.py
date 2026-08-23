from __future__ import annotations

from datetime import datetime
from typing import Annotated
from uuid import uuid4

from fastapi import Depends, FastAPI, HTTPException
from pydantic import AnyHttpUrl, BaseModel, Field
from sqlalchemy import select

from .audit import record_audit
from .connectors import TransferRequest, sandbox_connector
from .db import (
    CapacityOrderRow,
    ObligationRow,
    OrganizationRow,
    ParticipantRow,
    ReconciliationRow,
    RiskLimitRow,
    SessionLocal,
    TransferRow,
    WebhookEndpointRow,
    init_db,
)
from .domain import CapacityOrder, Money, Obligation, ParticipantId, Side
from .market import clear_capacity_market
from .netting import multilateral_net
from .outbox import deliver_pending, enqueue_event
from .security import (
    AuthContext,
    issue_api_key,
    require_admin,
    require_auth,
    revoke_api_key,
    rotate_api_key,
)

app = FastAPI(
    title="Liquidity Zero",
    version="0.3.0",
    description="Settlement Capacity Exchange API",
)
type Auth = Annotated[AuthContext, Depends(require_auth)]
type Admin = Annotated[None, Depends(require_admin)]


class OrganizationIn(BaseModel):
    id: str = Field(min_length=2, max_length=64, pattern=r"^[a-zA-Z0-9_-]+$")
    name: str = Field(min_length=1, max_length=160)


class ParticipantIn(BaseModel):
    external_id: str = Field(min_length=1, max_length=128)
    legal_name: str = Field(min_length=1, max_length=200)


class RiskLimitIn(BaseModel):
    currency: str = Field(min_length=3, max_length=16)
    credit_limit_minor: int = Field(ge=0)
    collateral_minor: int = Field(ge=0)
    max_single_transfer_minor: int = Field(gt=0)


class ObligationIn(BaseModel):
    payer: str = Field(min_length=1, max_length=128)
    payee: str = Field(min_length=1, max_length=128)
    currency: str = Field(min_length=3, max_length=16)
    amount_minor: int = Field(gt=0)
    due_at: datetime
    idempotency_key: str = Field(min_length=8, max_length=64)


class CapacityOrderIn(BaseModel):
    participant: str = Field(min_length=1, max_length=128)
    side: Side
    currency: str = Field(min_length=3, max_length=16)
    amount_minor: int = Field(gt=0)
    price_bps: int = Field(ge=0, le=100_000)
    window_start: datetime
    window_end: datetime
    idempotency_key: str = Field(min_length=8, max_length=64)


class TransferIn(BaseModel):
    participant_id: str = Field(min_length=1, max_length=64)
    amount_minor: int = Field(gt=0)
    currency: str = Field(min_length=3, max_length=16)
    source_account: str = Field(min_length=1, max_length=160)
    destination_account: str = Field(min_length=1, max_length=160)
    idempotency_key: str = Field(min_length=8, max_length=128)


class ReconciliationIn(BaseModel):
    external_reference: str = Field(min_length=1, max_length=160)
    currency: str = Field(min_length=3, max_length=16)
    expected_minor: int = Field(ge=0)
    observed_minor: int = Field(ge=0)


class WebhookEndpointIn(BaseModel):
    url: AnyHttpUrl
    secret: str = Field(min_length=16, max_length=256)


@app.on_event("startup")
def startup() -> None:
    init_db()


@app.get("/healthz")
def health() -> dict[str, str]:
    return {"status": "ok", "service": "liquidity-zero", "version": "0.3.0"}


@app.post("/v1/admin/organizations", status_code=201)
def create_organization(payload: OrganizationIn, _admin: Admin) -> dict[str, str]:
    with SessionLocal.begin() as session:
        if session.get(OrganizationRow, payload.id) is not None:
            raise HTTPException(status_code=409, detail="organization already exists")
        session.add(OrganizationRow(id=payload.id, name=payload.name))
        raw_key, key_row = issue_api_key(payload.id)
        session.add(key_row)
        record_audit(
            session,
            organization_id=payload.id,
            actor_key_id="admin",
            action="organization.created",
            resource_type="organization",
            resource_id=payload.id,
        )
    return {"organization_id": payload.id, "api_key": raw_key, "key_id": key_row.id}


@app.post("/v1/api-keys/rotate")
def rotate_current_key(auth: Auth) -> dict[str, str]:
    if auth.key_id == "bootstrap":
        raise HTTPException(status_code=409, detail="bootstrap key cannot be rotated")
    try:
        raw_key, key_id = rotate_api_key(auth.organization_id, auth.key_id)
    except ValueError as exc:
        raise HTTPException(status_code=404, detail=str(exc)) from exc
    enqueue_event(auth.organization_id, "api_key.rotated", {"key_id": key_id})
    return {"api_key": raw_key, "key_id": key_id}


@app.delete("/v1/admin/organizations/{organization_id}/api-keys/{key_id}", status_code=204)
def revoke_key(organization_id: str, key_id: str, _admin: Admin) -> None:
    try:
        revoke_api_key(organization_id, key_id)
    except ValueError as exc:
        raise HTTPException(status_code=404, detail=str(exc)) from exc


@app.post("/v1/participants", status_code=201)
def create_participant(payload: ParticipantIn, auth: Auth) -> dict[str, str]:
    with SessionLocal.begin() as session:
        existing = session.scalar(
            select(ParticipantRow)
            .where(ParticipantRow.organization_id == auth.organization_id)
            .where(ParticipantRow.external_id == payload.external_id)
        )
        if existing is not None:
            return {"id": existing.id, "external_id": existing.external_id}
        row = ParticipantRow(
            organization_id=auth.organization_id,
            external_id=payload.external_id,
            legal_name=payload.legal_name,
        )
        session.add(row)
        session.flush()
        record_audit(
            session,
            organization_id=auth.organization_id,
            actor_key_id=auth.key_id,
            action="participant.created",
            resource_type="participant",
            resource_id=row.id,
            payload={"external_id": row.external_id},
        )
        return {"id": row.id, "external_id": row.external_id}


@app.put("/v1/participants/{participant_id}/risk-limit")
def set_risk_limit(participant_id: str, payload: RiskLimitIn, auth: Auth) -> dict[str, object]:
    currency = payload.currency.upper()
    with SessionLocal.begin() as session:
        participant = session.get(ParticipantRow, participant_id)
        if participant is None or participant.organization_id != auth.organization_id:
            raise HTTPException(status_code=404, detail="participant not found")
        row = session.scalar(
            select(RiskLimitRow)
            .where(RiskLimitRow.organization_id == auth.organization_id)
            .where(RiskLimitRow.participant_id == participant_id)
            .where(RiskLimitRow.currency == currency)
            .with_for_update()
        )
        if row is None:
            row = RiskLimitRow(
                organization_id=auth.organization_id,
                participant_id=participant_id,
                currency=currency,
            )
            session.add(row)
        if payload.credit_limit_minor + payload.collateral_minor < row.reserved_minor:
            raise HTTPException(status_code=409, detail="new limit is below already reserved capacity")
        row.credit_limit_minor = payload.credit_limit_minor
        row.collateral_minor = payload.collateral_minor
        row.max_single_transfer_minor = payload.max_single_transfer_minor
        record_audit(
            session,
            organization_id=auth.organization_id,
            actor_key_id=auth.key_id,
            action="risk_limit.updated",
            resource_type="risk_limit",
            resource_id=row.id,
            payload={"currency": currency},
        )
        available = row.credit_limit_minor + row.collateral_minor - row.reserved_minor
    return {
        "participant_id": participant_id,
        "currency": currency,
        "available_capacity_minor": available,
        "reserved_minor": row.reserved_minor,
    }


@app.post("/v1/obligations", status_code=201)
def create_obligation(payload: ObligationIn, auth: Auth) -> dict[str, str]:
    obligation_id = f"obl_{payload.idempotency_key}"
    obligation = Obligation(
        id=obligation_id,
        payer=ParticipantId(payload.payer),
        payee=ParticipantId(payload.payee),
        amount=Money(payload.currency.upper(), payload.amount_minor),
        due_at=payload.due_at,
    )
    with SessionLocal.begin() as session:
        existing = session.get(ObligationRow, obligation.id)
        if existing is None:
            session.add(
                ObligationRow(
                    id=obligation.id,
                    organization_id=auth.organization_id,
                    payer=str(obligation.payer),
                    payee=str(obligation.payee),
                    currency=obligation.amount.currency,
                    amount_minor=obligation.amount.minor,
                    due_at=obligation.due_at,
                )
            )
        elif existing.organization_id != auth.organization_id:
            raise HTTPException(status_code=409, detail="idempotency key belongs to another tenant")
    return {"id": obligation.id}


@app.get("/v1/netting/{currency}")
def get_netting(currency: str, auth: Auth) -> list[dict[str, str | int]]:
    normalized = currency.upper()
    with SessionLocal() as session:
        rows = session.scalars(
            select(ObligationRow)
            .where(ObligationRow.organization_id == auth.organization_id)
            .where(ObligationRow.currency == normalized)
        ).all()
    obligations = [
        Obligation(
            id=row.id,
            payer=ParticipantId(row.payer),
            payee=ParticipantId(row.payee),
            amount=Money(row.currency, row.amount_minor),
            due_at=row.due_at,
        )
        for row in rows
    ]
    return [
        {
            "participant": str(position.participant),
            "currency": position.currency,
            "net_minor": position.minor,
            "direction": position.direction,
        }
        for position in multilateral_net(obligations)
    ]


@app.post("/v1/capacity/orders", status_code=201)
def create_capacity_order(payload: CapacityOrderIn, auth: Auth) -> dict[str, str]:
    order_id = f"ord_{payload.idempotency_key}"
    order = CapacityOrder(
        id=order_id,
        participant=ParticipantId(payload.participant),
        side=payload.side,
        currency=payload.currency.upper(),
        amount_minor=payload.amount_minor,
        price_bps=payload.price_bps,
        window_start=payload.window_start,
        window_end=payload.window_end,
    )
    with SessionLocal.begin() as session:
        existing = session.get(CapacityOrderRow, order.id)
        if existing is None:
            session.add(
                CapacityOrderRow(
                    id=order.id,
                    organization_id=auth.organization_id,
                    participant=str(order.participant),
                    side=order.side.value,
                    currency=order.currency,
                    amount_minor=order.amount_minor,
                    remaining_minor=order.amount_minor,
                    price_bps=order.price_bps,
                    window_start=order.window_start,
                    window_end=order.window_end,
                )
            )
        elif existing.organization_id != auth.organization_id:
            raise HTTPException(status_code=409, detail="idempotency key belongs to another tenant")
    return {"id": order.id}


@app.post("/v1/admin/capacity/clear/{currency}")
def clear_market(currency: str, _admin: Admin) -> dict[str, object]:
    normalized = currency.upper()
    with SessionLocal.begin() as session:
        rows = session.scalars(
            select(CapacityOrderRow)
            .where(CapacityOrderRow.currency == normalized)
            .where(CapacityOrderRow.remaining_minor > 0)
            .with_for_update()
        ).all()
        orders = [
            CapacityOrder(
                id=row.id,
                participant=ParticipantId(f"{row.organization_id}:{row.participant}"),
                side=Side(row.side),
                currency=row.currency,
                amount_minor=row.remaining_minor,
                price_bps=row.price_bps,
                window_start=row.window_start,
                window_end=row.window_end,
            )
            for row in rows
        ]
        fills = clear_capacity_market(orders)
        consumed: dict[str, int] = {}
        for fill in fills:
            consumed[fill.buy_order_id] = consumed.get(fill.buy_order_id, 0) + fill.amount_minor
            consumed[fill.sell_order_id] = consumed.get(fill.sell_order_id, 0) + fill.amount_minor
        by_id = {row.id: row for row in rows}
        for order_id, amount in consumed.items():
            row = by_id[order_id]
            if amount > row.remaining_minor:
                raise RuntimeError("market overfill invariant violated")
            row.remaining_minor -= amount
    return {
        "clearing_id": f"clr_{uuid4().hex}",
        "currency": normalized,
        "fills": [
            {
                "buyer": str(fill.buyer),
                "seller": str(fill.seller),
                "amount_minor": fill.amount_minor,
                "price_bps": fill.price_bps,
                "buy_order_id": fill.buy_order_id,
                "sell_order_id": fill.sell_order_id,
            }
            for fill in fills
        ],
    }


def _reserve_transfer(payload: TransferIn, auth: Auth, currency: str) -> TransferRow | dict[str, object]:
    with SessionLocal.begin() as session:
        existing = session.scalar(
            select(TransferRow)
            .where(TransferRow.organization_id == auth.organization_id)
            .where(TransferRow.idempotency_key == payload.idempotency_key)
        )
        if existing is not None:
            return _transfer_dict(existing)
        participant = session.get(ParticipantRow, payload.participant_id)
        if participant is None or participant.organization_id != auth.organization_id:
            raise HTTPException(status_code=404, detail="participant not found")
        limit = session.scalar(
            select(RiskLimitRow)
            .where(RiskLimitRow.organization_id == auth.organization_id)
            .where(RiskLimitRow.participant_id == payload.participant_id)
            .where(RiskLimitRow.currency == currency)
            .with_for_update()
        )
        if limit is None:
            raise HTTPException(status_code=409, detail="risk limit not configured")
        if payload.amount_minor > limit.max_single_transfer_minor:
            raise HTTPException(status_code=409, detail="single transfer limit exceeded")
        available = limit.credit_limit_minor + limit.collateral_minor - limit.reserved_minor
        if payload.amount_minor > available:
            raise HTTPException(status_code=409, detail="available settlement capacity exceeded")
        limit.reserved_minor += payload.amount_minor
        row = TransferRow(
            organization_id=auth.organization_id,
            participant_id=payload.participant_id,
            idempotency_key=payload.idempotency_key,
            connector=sandbox_connector.name,
            provider_transfer_id="",
            state="reserved",
            amount_minor=payload.amount_minor,
            currency=currency,
            source_account=payload.source_account,
            destination_account=payload.destination_account,
            reserved_minor=payload.amount_minor,
        )
        session.add(row)
        session.flush()
        record_audit(
            session,
            organization_id=auth.organization_id,
            actor_key_id=auth.key_id,
            action="transfer.reserved",
            resource_type="transfer",
            resource_id=row.id,
            payload={"amount_minor": payload.amount_minor, "currency": currency},
        )
        session.expunge(row)
        return row


@app.post("/v1/transfers", status_code=201)
def create_transfer(payload: TransferIn, auth: Auth) -> dict[str, object]:
    currency = payload.currency.upper()
    reserved = _reserve_transfer(payload, auth, currency)
    if isinstance(reserved, dict):
        return reserved
    try:
        result = sandbox_connector.submit(
            TransferRequest(
                organization_id=auth.organization_id,
                idempotency_key=payload.idempotency_key,
                amount_minor=payload.amount_minor,
                currency=currency,
                source_account=payload.source_account,
                destination_account=payload.destination_account,
            )
        )
    except Exception:
        _fail_and_release(reserved.id, auth.organization_id)
        enqueue_event(auth.organization_id, "transfer.failed", {"id": reserved.id})
        raise
    with SessionLocal.begin() as session:
        row = session.get(TransferRow, reserved.id)
        if row is None:
            raise RuntimeError("reserved transfer disappeared")
        row.provider_transfer_id = result.provider_transfer_id
        row.state = result.state.value
        response = _transfer_dict(row)
        record_audit(
            session,
            organization_id=auth.organization_id,
            actor_key_id=auth.key_id,
            action="transfer.submitted",
            resource_type="transfer",
            resource_id=row.id,
            payload={"provider_transfer_id": result.provider_transfer_id},
        )
    enqueue_event(auth.organization_id, "transfer.accepted", response)
    return response


def _fail_and_release(transfer_id: str, organization_id: str) -> None:
    with SessionLocal.begin() as session:
        row = session.get(TransferRow, transfer_id)
        if row is None or row.organization_id != organization_id:
            return
        if row.reserved_minor > 0:
            limit = session.scalar(
                select(RiskLimitRow)
                .where(RiskLimitRow.organization_id == organization_id)
                .where(RiskLimitRow.participant_id == row.participant_id)
                .where(RiskLimitRow.currency == row.currency)
                .with_for_update()
            )
            if limit is not None:
                limit.reserved_minor = max(0, limit.reserved_minor - row.reserved_minor)
            row.reserved_minor = 0
        row.state = "failed"


@app.post("/v1/admin/transfers/{transfer_id}/settle")
def settle_transfer(transfer_id: str, _admin: Admin) -> dict[str, object]:
    with SessionLocal.begin() as session:
        row = session.get(TransferRow, transfer_id)
        if row is None:
            raise HTTPException(status_code=404, detail="transfer not found")
        if row.state == "settled":
            return _transfer_dict(row)
        limit = session.scalar(
            select(RiskLimitRow)
            .where(RiskLimitRow.organization_id == row.organization_id)
            .where(RiskLimitRow.participant_id == row.participant_id)
            .where(RiskLimitRow.currency == row.currency)
            .with_for_update()
        )
        if limit is None:
            raise RuntimeError("risk limit missing for reserved transfer")
        if row.reserved_minor > limit.reserved_minor:
            raise RuntimeError("reservation accounting invariant violated")
        limit.reserved_minor -= row.reserved_minor
        row.reserved_minor = 0
        row.state = "settled"
        response = _transfer_dict(row)
    enqueue_event(row.organization_id, "transfer.settled", response)
    return response


@app.get("/v1/transfers/{transfer_id}")
def get_transfer(transfer_id: str, auth: Auth) -> dict[str, object]:
    with SessionLocal() as session:
        row = session.get(TransferRow, transfer_id)
        if row is None or row.organization_id != auth.organization_id:
            raise HTTPException(status_code=404, detail="transfer not found")
        return _transfer_dict(row)


def _transfer_dict(row: TransferRow) -> dict[str, object]:
    return {
        "id": row.id,
        "state": row.state,
        "connector": row.connector,
        "provider_transfer_id": row.provider_transfer_id,
        "amount_minor": row.amount_minor,
        "currency": row.currency,
        "reserved_minor": row.reserved_minor,
    }


@app.post("/v1/reconciliation", status_code=201)
def reconcile(payload: ReconciliationIn, auth: Auth) -> dict[str, object]:
    normalized = payload.currency.upper()
    item_status = "matched" if payload.expected_minor == payload.observed_minor else "mismatch"
    with SessionLocal.begin() as session:
        existing = session.scalar(
            select(ReconciliationRow)
            .where(ReconciliationRow.organization_id == auth.organization_id)
            .where(ReconciliationRow.external_reference == payload.external_reference)
        )
        if existing is not None:
            return _reconciliation_dict(existing)
        row = ReconciliationRow(
            organization_id=auth.organization_id,
            external_reference=payload.external_reference,
            currency=normalized,
            expected_minor=payload.expected_minor,
            observed_minor=payload.observed_minor,
            status=item_status,
        )
        session.add(row)
        session.flush()
        response = _reconciliation_dict(row)
        record_audit(
            session,
            organization_id=auth.organization_id,
            actor_key_id=auth.key_id,
            action=f"reconciliation.{item_status}",
            resource_type="reconciliation",
            resource_id=row.id,
        )
    enqueue_event(auth.organization_id, f"reconciliation.{item_status}", response)
    return response


def _reconciliation_dict(row: ReconciliationRow) -> dict[str, object]:
    return {
        "id": row.id,
        "external_reference": row.external_reference,
        "currency": row.currency,
        "expected_minor": row.expected_minor,
        "observed_minor": row.observed_minor,
        "delta_minor": row.observed_minor - row.expected_minor,
        "status": row.status,
    }


@app.post("/v1/webhook-endpoints", status_code=201)
def create_webhook_endpoint(payload: WebhookEndpointIn, auth: Auth) -> dict[str, str]:
    with SessionLocal.begin() as session:
        row = WebhookEndpointRow(
            organization_id=auth.organization_id,
            url=str(payload.url),
            secret=payload.secret,
        )
        session.add(row)
        session.flush()
        record_audit(
            session,
            organization_id=auth.organization_id,
            actor_key_id=auth.key_id,
            action="webhook_endpoint.created",
            resource_type="webhook_endpoint",
            resource_id=row.id,
        )
        return {"id": row.id, "url": row.url}


@app.post("/v1/webhook-endpoints/{endpoint_id}/test")
def test_webhook(endpoint_id: str, auth: Auth) -> dict[str, object]:
    with SessionLocal() as session:
        endpoint = session.get(WebhookEndpointRow, endpoint_id)
        if endpoint is None or endpoint.organization_id != auth.organization_id:
            raise HTTPException(status_code=404, detail="webhook endpoint not found")
    event_id = enqueue_event(
        auth.organization_id,
        "integration.test",
        {"endpoint_id": endpoint_id},
    )
    return {"event_id": event_id, "status": "queued"}


@app.post("/v1/admin/outbox/deliver")
def run_outbox(_admin: Admin) -> dict[str, int]:
    return {"delivered": deliver_pending()}
