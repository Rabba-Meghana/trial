from __future__ import annotations

import json
from datetime import datetime
from typing import Annotated
from uuid import uuid4

from fastapi import Depends, FastAPI, HTTPException
from pydantic import AnyHttpUrl, BaseModel, Field
from sqlalchemy import select

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
    WebhookEventRow,
    init_db,
)
from .delivery import deliver
from .domain import CapacityOrder, Money, Obligation, ParticipantId, Side
from .market import clear_capacity_market
from .netting import multilateral_net
from .security import AuthContext, issue_api_key, require_admin, require_auth
from .webhooks import WebhookEnvelope, build_delivery

app = FastAPI(title="Liquidity Zero", version="0.2.0", description="Settlement Capacity Exchange API")
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
    return {"status": "ok", "service": "liquidity-zero", "version": "0.2.0"}


@app.post("/v1/admin/organizations", status_code=201)
def create_organization(payload: OrganizationIn, _admin: Admin) -> dict[str, str]:
    with SessionLocal.begin() as session:
        if session.get(OrganizationRow, payload.id) is not None:
            raise HTTPException(status_code=409, detail="organization already exists")
        session.add(OrganizationRow(id=payload.id, name=payload.name))
        raw_key, key_row = issue_api_key(payload.id)
        session.add(key_row)
    return {"organization_id": payload.id, "api_key": raw_key, "key_id": key_row.id}


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
        )
        if row is None:
            row = RiskLimitRow(
                organization_id=auth.organization_id,
                participant_id=participant_id,
                currency=currency,
            )
            session.add(row)
        row.credit_limit_minor = payload.credit_limit_minor
        row.collateral_minor = payload.collateral_minor
        row.max_single_transfer_minor = payload.max_single_transfer_minor
    return {
        "participant_id": participant_id,
        "currency": currency,
        "available_capacity_minor": payload.credit_limit_minor + payload.collateral_minor,
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


@app.post("/v1/transfers", status_code=201)
def create_transfer(payload: TransferIn, auth: Auth) -> dict[str, object]:
    currency = payload.currency.upper()
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
        )
        if limit is None:
            raise HTTPException(status_code=409, detail="risk limit not configured")
        if payload.amount_minor > limit.max_single_transfer_minor:
            raise HTTPException(status_code=409, detail="single transfer limit exceeded")
        if payload.amount_minor > limit.credit_limit_minor + limit.collateral_minor:
            raise HTTPException(status_code=409, detail="available settlement capacity exceeded")
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
        row = TransferRow(
            organization_id=auth.organization_id,
            idempotency_key=payload.idempotency_key,
            connector=sandbox_connector.name,
            provider_transfer_id=result.provider_transfer_id,
            state=result.state.value,
            amount_minor=payload.amount_minor,
            currency=currency,
            source_account=payload.source_account,
            destination_account=payload.destination_account,
        )
        session.add(row)
        session.flush()
        response = _transfer_dict(row)
    _emit_event(auth.organization_id, "transfer.accepted", response)
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
    _emit_event(auth.organization_id, f"reconciliation.{item_status}", response)
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
        return {"id": row.id, "url": row.url}


@app.post("/v1/webhook-endpoints/{endpoint_id}/test")
def test_webhook(endpoint_id: str, auth: Auth) -> dict[str, object]:
    with SessionLocal() as session:
        endpoint = session.get(WebhookEndpointRow, endpoint_id)
        if endpoint is None or endpoint.organization_id != auth.organization_id:
            raise HTTPException(status_code=404, detail="webhook endpoint not found")
    event_id = _emit_event(auth.organization_id, "integration.test", {"endpoint_id": endpoint_id})
    return {"event_id": event_id, "status": "dispatched"}


def _emit_event(organization_id: str, event_type: str, data: dict[str, object]) -> str:
    payload_json = json.dumps(data, separators=(",", ":"), sort_keys=True)
    with SessionLocal.begin() as session:
        event = WebhookEventRow(
            organization_id=organization_id,
            event_type=event_type,
            payload_json=payload_json,
        )
        session.add(event)
        session.flush()
        event_id = event.id
        created_at = event.created_at
        endpoints = session.scalars(
            select(WebhookEndpointRow)
            .where(WebhookEndpointRow.organization_id == organization_id)
            .where(WebhookEndpointRow.status == "active")
        ).all()
    delivered = True
    for endpoint in endpoints:
        envelope = WebhookEnvelope(
            event_id=event_id,
            event_type=event_type,
            organization_id=organization_id,
            created_at=created_at,
            data=data,
        )
        body, headers = build_delivery(endpoint.secret, envelope)
        result = deliver(endpoint.url, body, headers)
        delivered = delivered and 200 <= result.status_code < 300
    with SessionLocal.begin() as session:
        stored = session.get(WebhookEventRow, event_id)
        if stored is not None:
            stored.delivery_status = "delivered" if delivered else "failed"
    return event_id
