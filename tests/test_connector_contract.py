from __future__ import annotations

from uuid import uuid4

import pytest

from lz.connectors import SandboxConnector, TransferRequest, TransferState


def _request(*, idempotency_key: str, amount_minor: int = 100) -> TransferRequest:
    return TransferRequest(
        organization_id=f"org-{uuid4().hex}",
        idempotency_key=idempotency_key,
        amount_minor=amount_minor,
        currency="USD",
        source_account="source",
        destination_account="destination",
    )


def test_connector_submit_is_idempotent() -> None:
    connector = SandboxConnector()
    request = _request(idempotency_key=f"idem-{uuid4().hex}")

    first = connector.submit(request)
    second = connector.submit(request)

    assert second.provider_transfer_id == first.provider_transfer_id
    assert second.state == first.state


def test_connector_get_returns_submitted_transfer() -> None:
    connector = SandboxConnector()
    submitted = connector.submit(_request(idempotency_key=f"idem-{uuid4().hex}"))

    observed = connector.get(submitted.provider_transfer_id)

    assert observed == submitted
    assert observed.state is TransferState.ACCEPTED


def test_connector_rejects_nonpositive_amount() -> None:
    connector = SandboxConnector()

    with pytest.raises(ValueError, match="amount must be positive"):
        connector.submit(_request(idempotency_key=f"idem-{uuid4().hex}", amount_minor=0))


def test_connector_does_not_cross_tenant_idempotency_domains() -> None:
    connector = SandboxConnector()
    idem = f"idem-{uuid4().hex}"
    first = TransferRequest("org-a", idem, 100, "USD", "a", "b")
    second = TransferRequest("org-b", idem, 100, "USD", "a", "b")

    first_result = connector.submit(first)
    second_result = connector.submit(second)

    assert first_result.provider_transfer_id != second_result.provider_transfer_id
