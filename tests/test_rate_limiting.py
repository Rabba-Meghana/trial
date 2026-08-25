from __future__ import annotations

from uuid import uuid4

from fastapi.testclient import TestClient

from lz.api import app
from lz.config import settings


def test_tenant_rate_limit_returns_429(monkeypatch) -> None:  # type: ignore[no-untyped-def]
    client = TestClient(app)
    suffix = uuid4().hex[:12]
    organization_id = f"rate-{suffix}"

    provisioned = client.post(
        "/v1/admin/organizations",
        headers={"X-API-Key": settings.api_key},
        json={"id": organization_id, "name": "Rate Limit Test"},
    )
    assert provisioned.status_code == 201
    tenant_key = provisioned.json()["api_key"]
    headers = {"X-API-Key": tenant_key}

    monkeypatch.setattr(settings, "tenant_rate_limit_per_minute", 2)

    first = client.post(
        "/v1/participants",
        headers=headers,
        json={"external_id": f"merchant-{uuid4().hex}", "legal_name": "Merchant One LLC"},
    )
    second = client.post(
        "/v1/participants",
        headers=headers,
        json={"external_id": f"merchant-{uuid4().hex}", "legal_name": "Merchant Two LLC"},
    )
    blocked = client.post(
        "/v1/participants",
        headers=headers,
        json={"external_id": f"merchant-{uuid4().hex}", "legal_name": "Merchant Three LLC"},
    )

    assert first.status_code == 201
    assert second.status_code == 201
    assert blocked.status_code == 429
    assert blocked.json()["detail"] == "API rate limit exceeded"
    assert blocked.headers["Retry-After"] == "60"
