from __future__ import annotations

import secrets
from datetime import datetime
from typing import Annotated
from uuid import uuid4

from fastapi import Depends, FastAPI, Header, HTTPException, status
from pydantic import BaseModel, Field
from sqlalchemy import select

from .config import settings
from .db import CapacityOrderRow, ObligationRow, SessionLocal, init_db
from .domain import CapacityOrder, Money, Obligation, ParticipantId, Side
from .market import clear_capacity_market
from .netting import multilateral_net

app = FastAPI(
    title="Liquidity Zero",
    version="0.1.0",
    description="Settlement Capacity Exchange API",
)


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


def require_api_key(x_api_key: Annotated[str, Header()]) -> None:
    if not secrets.compare_digest(x_api_key, settings.api_key):
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="invalid API key")


@app.on_event("startup")
def startup() -> None:
    init_db()


@app.get("/healthz")
def health() -> dict[str, str]:
    return {"status": "ok", "environment": settings.environment}


@app.post("/v1/obligations", dependencies=[Depends(require_api_key)], status_code=201)
def create_obligation(payload: ObligationIn) -> dict[str, str]:
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
                    payer=str(obligation.payer),
                    payee=str(obligation.payee),
                    currency=obligation.amount.currency,
                    amount_minor=obligation.amount.minor,
                    due_at=obligation.due_at,
                )
            )
    return {"id": obligation.id}


@app.get("/v1/netting/{currency}", dependencies=[Depends(require_api_key)])
def get_netting(currency: str) -> list[dict[str, str | int]]:
    normalized = currency.upper()
    with SessionLocal() as session:
        rows = session.scalars(
            select(ObligationRow).where(ObligationRow.currency == normalized)
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


@app.post("/v1/capacity/orders", dependencies=[Depends(require_api_key)], status_code=201)
def create_capacity_order(payload: CapacityOrderIn) -> dict[str, str]:
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
    return {"id": order.id}


@app.post("/v1/capacity/clear/{currency}", dependencies=[Depends(require_api_key)])
def clear_market(currency: str) -> dict[str, object]:
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
                participant=ParticipantId(row.participant),
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
