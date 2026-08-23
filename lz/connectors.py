from __future__ import annotations

from dataclasses import dataclass
from datetime import UTC, datetime
from enum import StrEnum
from typing import Protocol
from uuid import uuid4


class TransferState(StrEnum):
    ACCEPTED = "accepted"
    SETTLED = "settled"
    FAILED = "failed"


@dataclass(frozen=True, slots=True)
class TransferRequest:
    organization_id: str
    idempotency_key: str
    amount_minor: int
    currency: str
    source_account: str
    destination_account: str


@dataclass(frozen=True, slots=True)
class TransferResult:
    provider_transfer_id: str
    state: TransferState
    submitted_at: datetime


class SettlementConnector(Protocol):
    name: str

    def submit(self, request: TransferRequest) -> TransferResult: ...

    def get(self, provider_transfer_id: str) -> TransferResult: ...


class SandboxConnector:
    name = "sandbox"

    def __init__(self) -> None:
        self._transfers: dict[str, TransferResult] = {}
        self._idempotency: dict[tuple[str, str], str] = {}

    def submit(self, request: TransferRequest) -> TransferResult:
        key = (request.organization_id, request.idempotency_key)
        existing_id = self._idempotency.get(key)
        if existing_id is not None:
            return self._transfers[existing_id]
        if request.amount_minor <= 0:
            raise ValueError("amount must be positive")
        provider_id = f"sbx_{uuid4().hex}"
        result = TransferResult(provider_id, TransferState.ACCEPTED, datetime.now(UTC))
        self._transfers[provider_id] = result
        self._idempotency[key] = provider_id
        return result

    def get(self, provider_transfer_id: str) -> TransferResult:
        try:
            return self._transfers[provider_transfer_id]
        except KeyError as exc:
            raise KeyError("unknown sandbox transfer") from exc


sandbox_connector = SandboxConnector()
