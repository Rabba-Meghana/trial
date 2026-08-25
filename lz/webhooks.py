from __future__ import annotations

import json
from dataclasses import dataclass
from datetime import UTC, datetime
from typing import Any

from .security import sign_webhook


@dataclass(frozen=True, slots=True)
class WebhookEnvelope:
    event_id: str
    event_type: str
    organization_id: str
    created_at: datetime
    data: dict[str, Any]

    def to_bytes(self) -> bytes:
        payload = {
            "id": self.event_id,
            "type": self.event_type,
            "organization_id": self.organization_id,
            "created_at": self.created_at.astimezone(UTC).isoformat(),
            "data": self.data,
        }
        return json.dumps(payload, separators=(",", ":"), sort_keys=True).encode("utf-8")


def build_delivery(secret: str, envelope: WebhookEnvelope) -> tuple[bytes, dict[str, str]]:
    payload = envelope.to_bytes()
    timestamp = int(datetime.now(UTC).timestamp())
    return payload, {
        "Content-Type": "application/json",
        "X-LZ-Timestamp": str(timestamp),
        "X-LZ-Signature": sign_webhook(secret, timestamp, payload),
        "X-LZ-Event-ID": envelope.event_id,
    }
