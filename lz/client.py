from __future__ import annotations

from dataclasses import dataclass
from datetime import datetime
from typing import Any

import httpx


@dataclass(slots=True)
class LiquidityZeroClient:
    api_key: str
    organization_id: str
    base_url: str = "http://localhost:8080"
    timeout_seconds: float = 10.0

    def _headers(self) -> dict[str, str]:
        return {
            "X-API-Key": self.api_key,
            "X-LZ-Organization": self.organization_id,
            "Content-Type": "application/json",
        }

    def _request(self, method: str, path: str, json: dict[str, Any] | None = None) -> Any:
        with httpx.Client(base_url=self.base_url, timeout=self.timeout_seconds) as client:
            response = client.request(method, path, headers=self._headers(), json=json)
            response.raise_for_status()
            return response.json()

    def create_participant(self, *, external_id: str, legal_name: str) -> dict[str, Any]:
        return self._request(
            "POST",
            "/v1/participants",
            {"external_id": external_id, "legal_name": legal_name},
        )

    def set_risk_limit(
        self,
        *,
        participant_id: str,
        currency: str,
        credit_limit_minor: int,
        collateral_minor: int,
        max_single_transfer_minor: int,
    ) -> dict[str, Any]:
        return self._request(
            "PUT",
            f"/v1/participants/{participant_id}/risk-limit",
            {
                "currency": currency,
                "credit_limit_minor": credit_limit_minor,
                "collateral_minor": collateral_minor,
                "max_single_transfer_minor": max_single_transfer_minor,
            },
        )

    def create_obligation(
        self,
        *,
        payer: str,
        payee: str,
        currency: str,
        amount_minor: int,
        due_at: datetime,
        idempotency_key: str,
    ) -> dict[str, Any]:
        return self._request(
            "POST",
            "/v1/obligations",
            {
                "payer": payer,
                "payee": payee,
                "currency": currency,
                "amount_minor": amount_minor,
                "due_at": due_at.isoformat(),
                "idempotency_key": idempotency_key,
            },
        )

    def netting(self, currency: str) -> list[dict[str, Any]]:
        result = self._request("GET", f"/v1/netting/{currency}")
        if not isinstance(result, list):
            raise TypeError("unexpected netting response")
        return result

    def create_transfer(
        self,
        *,
        participant_id: str,
        amount_minor: int,
        currency: str,
        source_account: str,
        destination_account: str,
        idempotency_key: str,
    ) -> dict[str, Any]:
        return self._request(
            "POST",
            "/v1/transfers",
            {
                "participant_id": participant_id,
                "amount_minor": amount_minor,
                "currency": currency,
                "source_account": source_account,
                "destination_account": destination_account,
                "idempotency_key": idempotency_key,
            },
        )

    def get_transfer(self, transfer_id: str) -> dict[str, Any]:
        return self._request("GET", f"/v1/transfers/{transfer_id}")

    def reconcile(
        self,
        *,
        external_reference: str,
        currency: str,
        expected_minor: int,
        observed_minor: int,
    ) -> dict[str, Any]:
        return self._request(
            "POST",
            "/v1/reconciliation",
            {
                "external_reference": external_reference,
                "currency": currency,
                "expected_minor": expected_minor,
                "observed_minor": observed_minor,
            },
        )
