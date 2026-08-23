from __future__ import annotations

import json
from datetime import UTC, datetime, timedelta

from sqlalchemy import select

from .db import SessionLocal, WebhookEndpointRow, WebhookEventRow
from .delivery import deliver
from .webhooks import WebhookEnvelope, build_delivery

MAX_ATTEMPTS = 8


def utcnow() -> datetime:
    return datetime.now(UTC)


def enqueue_event(organization_id: str, event_type: str, data: dict[str, object]) -> str:
    with SessionLocal.begin() as session:
        event = WebhookEventRow(
            organization_id=organization_id,
            event_type=event_type,
            payload_json=json.dumps(data, separators=(",", ":"), sort_keys=True),
            delivery_status="pending",
            next_attempt_at=utcnow(),
        )
        session.add(event)
        session.flush()
        return event.id


def deliver_pending(limit: int = 100) -> int:
    delivered_count = 0
    now = utcnow()
    with SessionLocal.begin() as session:
        events = session.scalars(
            select(WebhookEventRow)
            .where(WebhookEventRow.delivery_status.in_(["pending", "retrying"]))
            .where(WebhookEventRow.next_attempt_at <= now)
            .order_by(WebhookEventRow.created_at)
            .limit(limit)
            .with_for_update(skip_locked=True)
        ).all()
        for event in events:
            endpoints = session.scalars(
                select(WebhookEndpointRow)
                .where(WebhookEndpointRow.organization_id == event.organization_id)
                .where(WebhookEndpointRow.status == "active")
            ).all()
            data = json.loads(event.payload_json)
            success = True
            last_error = ""
            for endpoint in endpoints:
                envelope = WebhookEnvelope(
                    event_id=event.id,
                    event_type=event.event_type,
                    organization_id=event.organization_id,
                    created_at=event.created_at,
                    data=data,
                )
                body, headers = build_delivery(endpoint.secret, envelope)
                try:
                    result = deliver(endpoint.url, body, headers)
                    if not 200 <= result.status_code < 300:
                        success = False
                        last_error = f"HTTP {result.status_code}"
                except Exception as exc:  # network failures are retried by design
                    success = False
                    last_error = type(exc).__name__
            event.attempts += 1
            if success:
                event.delivery_status = "delivered"
                event.last_error = ""
                delivered_count += 1
            elif event.attempts >= MAX_ATTEMPTS:
                event.delivery_status = "dead_letter"
                event.last_error = last_error
            else:
                event.delivery_status = "retrying"
                event.last_error = last_error
                delay_seconds = min(3600, 2 ** event.attempts)
                event.next_attempt_at = now + timedelta(seconds=delay_seconds)
    return delivered_count


if __name__ == "__main__":
    deliver_pending()
