from __future__ import annotations

import json

from sqlalchemy.orm import Session

from .db import AuditEventRow


def record_audit(
    session: Session,
    *,
    organization_id: str,
    actor_key_id: str,
    action: str,
    resource_type: str,
    resource_id: str,
    payload: dict[str, object] | None = None,
) -> None:
    session.add(
        AuditEventRow(
            organization_id=organization_id,
            actor_key_id=actor_key_id,
            action=action,
            resource_type=resource_type,
            resource_id=resource_id,
            payload_json=json.dumps(payload or {}, separators=(",", ":"), sort_keys=True),
        )
    )
