from fastapi.testclient import TestClient

from lz.api import app
from lz.provision import provision


def test_direct_integration_contract() -> None:
    organization_id = "contract-test-org"
    api_key = provision(organization_id, "Contract Test Org")
    headers = {"X-API-Key": api_key}

    with TestClient(app) as client:
        participant_response = client.post(
            "/v1/participants",
            headers=headers,
            json={"external_id": "merchant-001", "legal_name": "Merchant One LLC"},
        )
        assert participant_response.status_code == 201
        participant_id = participant_response.json()["id"]

        risk_response = client.put(
            f"/v1/participants/{participant_id}/risk-limit",
            headers=headers,
            json={
                "currency": "USD",
                "credit_limit_minor": 500_000,
                "collateral_minor": 500_000,
                "max_single_transfer_minor": 750_000,
            },
        )
        assert risk_response.status_code == 200
        assert risk_response.json()["available_capacity_minor"] == 1_000_000

        transfer_payload = {
            "participant_id": participant_id,
            "amount_minor": 250_000,
            "currency": "USD",
            "source_account": "wallet:merchant-001",
            "destination_account": "bank:beneficiary-001",
            "idempotency_key": "contract-transfer-001",
        }
        first = client.post("/v1/transfers", headers=headers, json=transfer_payload)
        second = client.post("/v1/transfers", headers=headers, json=transfer_payload)
        assert first.status_code == 201
        assert second.status_code == 201
        assert first.json()["id"] == second.json()["id"]
        assert first.json()["connector"] == "sandbox"

        over_limit = client.post(
            "/v1/transfers",
            headers=headers,
            json={**transfer_payload, "amount_minor": 800_000, "idempotency_key": "over-limit-001"},
        )
        assert over_limit.status_code == 409

        reconciliation = client.post(
            "/v1/reconciliation",
            headers=headers,
            json={
                "external_reference": "statement-line-001",
                "currency": "USD",
                "expected_minor": 250_000,
                "observed_minor": 249_900,
            },
        )
        assert reconciliation.status_code == 201
        assert reconciliation.json()["status"] == "mismatch"
        assert reconciliation.json()["delta_minor"] == -100
