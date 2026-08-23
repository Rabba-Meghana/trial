from __future__ import annotations

from dataclasses import dataclass
from datetime import datetime
from enum import StrEnum
from typing import NewType

ParticipantId = NewType("ParticipantId", str)


class Side(StrEnum):
    BUY = "buy"
    SELL = "sell"


@dataclass(frozen=True, slots=True)
class Money:
    currency: str
    minor: int

    def __post_init__(self) -> None:
        if not self.currency or len(self.currency) < 3:
            raise ValueError("currency must be a canonical asset code")

    def _check(self, other: Money) -> None:
        if self.currency != other.currency:
            raise ValueError("currency mismatch")

    def __add__(self, other: Money) -> Money:
        self._check(other)
        return Money(self.currency, self.minor + other.minor)

    def __sub__(self, other: Money) -> Money:
        self._check(other)
        return Money(self.currency, self.minor - other.minor)


@dataclass(frozen=True, slots=True)
class Obligation:
    id: str
    payer: ParticipantId
    payee: ParticipantId
    amount: Money
    due_at: datetime

    def __post_init__(self) -> None:
        if self.payer == self.payee:
            raise ValueError("payer and payee must differ")
        if self.amount.minor <= 0:
            raise ValueError("obligation amount must be positive")


@dataclass(frozen=True, slots=True)
class CapacityOrder:
    id: str
    participant: ParticipantId
    side: Side
    currency: str
    amount_minor: int
    price_bps: int
    window_start: datetime
    window_end: datetime

    def __post_init__(self) -> None:
        if self.amount_minor <= 0:
            raise ValueError("capacity amount must be positive")
        if self.price_bps < 0:
            raise ValueError("price_bps cannot be negative")
        if self.window_end <= self.window_start:
            raise ValueError("invalid settlement window")


@dataclass(frozen=True, slots=True)
class CapacityFill:
    buy_order_id: str
    sell_order_id: str
    buyer: ParticipantId
    seller: ParticipantId
    currency: str
    amount_minor: int
    price_bps: int
