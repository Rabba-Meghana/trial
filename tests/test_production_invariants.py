from __future__ import annotations

from uuid import uuid4

from fastapi.testclient import TestClient

from lz.api import app
from lz.config import settings


def _admin_headers() -> dict[str, str]:
    return {"X-API-Key": settings.api_key}


def _tenant() -> tuple[TestClient, str, dict[str, str]]:
    client = TestClient(app)
    suffix = uuid4().hex[:12]
    organization_id = f"org-{suffix}"
    response = client.post(
        "/v1/admin/organizations",
        headers=_admin_headers(),
        json={"id": organization_id, "name": f"Organization {suffix}"},
    )
    assert response.status_code == 201
    api_key = response.json()["api_key"]
    return client, organization_id, {"X-API-Key": api_key}


def _participant_with_limit(
    client: TestClient,
    headers: dict[str, str],
    *,
    total_capacity: int = 1_000,
) -> str:
    participant = client.post(
        "/v1/participants",
        headers=headers,
        json={"external_id": f"merchant-{uuid4().hex}", "legal_name": "Merchant LLC"},
    )
    assert participant.status_code == 201
    participant_id = participant.json()["id"]
    limit = client.put(
        f"/v1/participants/{participant_id}/risk-limit",
        headers=headers,
        json={
            "currency": "USD",
            "credit_limit_minor": total_capacity,
            "collateral_minor": 0,
            "max_single_transfer_minor": total_capacity,
        },
    )
    assert limit.status_code == 200
    return participant_id


def _transfer_payload(participant_id: str, amount: int, idem: str) -> dict[str, object]:
    return {
        "participant_id": participant_id,
        "amount_minor": amount,
        "currency": "USD",
        "source_account": "wallet:source",
        "destination_account": "bank:destination",
        "idempotency_key": idem,
    }


def test_capacity_is_reserved_and_cannot_be_double_spent() -> None:
    client, _, headers = _tenant()
    participant_id = _participant_with_limit(client, headers, total_capacity=1_000)

    first = client.post(
        "/v1/transfers",
        headers=headers,
        json=_transfer_payload(participant_id, 700, f"idem-{uuid4().hex}"),
    )
    assert first.status_code == 201
    assert first.json()["reserved_minor"] == 700

    second = client.post(
        "/v1/transfers",
        headers=headers,
        json=_transfer_payload(participant_id, 400, f"idem-{uuid4().hex}"),
    )
    assert second.status_code == 409
    assert second.json()["detail"] == "available settlement capacity exceeded"


def test_idempotent_retry_does_not_reserve_twice() -> None:
    client, _, headers = _tenant()
    participant_id = _participant_with_limit(client, headers, total_capacity=1_000)
    idem = f"idem-{uuid4().hex}"
    payload = _transfer_payload(participant_id, 700, idem)

    first = client.post("/v1/transfers", headers=headers, json=payload)
    retry = client.post("/v1/transfers", headers=headers, json=payload)

    assert first.status_code == 201
    assert retry.status_code == 201
    assert retry.json()["id"] == first.json()["id"]
    assert retry.json()["reserved_minor"] == 700


def test_settlement_releases_reserved_capacity() -> None:
    client, _, headers = _tenant()
    participant_id = _participant_with_limit(client, headers, total_capacity=1_000)
    transfer = client.post(
        "/v1/transfers",
        headers=headers,
        json=_transfer_payload(participant_id, 700, f"idem-{uuid4().hex}"),
    )
    transfer_id = transfer.json()["id"]

    settled = client.post(
        f"/v1/admin/transfers/{transfer_id}/settle",
        headers=_admin_headers(),
    )
    assert settled.status_code == 200
    assert settled.json()["state"] == "settled"
    assert settled.json()["reserved_minor"] == 0

    next_transfer = client.post(
        "/v1/transfers",
        headers=headers,
        json=_transfer_payload(participant_id, 1_000, f"idem-{uuid4().hex}"),
    )
    assert next_transfer.status_code == 201


def test_key_rotation_revokes_previous_key() -> None:
    client, _, headers = _tenant()
    old_key = headers["X-API-Key"]

    rotated = client.post("/v1/api-keys/rotate", headers=headers)
    assert rotated.status_code == 200
    new_key = rotated.json()["api_key"]
    assert new_key != old_key

    old_response = client.post(
        "/v1/participants",
        headers={"X-API-Key": old_key},
        json={"external_id": f"old-{uuid4().hex}", "legal_name": "Old Key LLC"},
    )
    assert old_response.status_code == 401

    new_response = client.post(
        "/v1/participants",
        headers={"X-API-Key": new_key},
        json={"external_id": f"new-{uuid4().hex}", "legal_name": "New Key LLC"},
    )
    assert new_response.status_code == 201
