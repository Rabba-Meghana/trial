from __future__ import annotations

import hashlib
import hmac
import secrets
from dataclasses import dataclass
from datetime import UTC, datetime
from typing import Annotated

from fastapi import Header, HTTPException, status

from .config import settings


@dataclass(frozen=True, slots=True)
class AuthContext:
    organization_id: str
    key_id: str


def hash_api_key(raw_key: str) -> str:
    return hashlib.sha256(raw_key.encode("utf-8")).hexdigest()


def require_auth(
    x_api_key: Annotated[str, Header()],
    x_lz_organization: Annotated[str | None, Header()] = None,
) -> AuthContext:
    if secrets.compare_digest(x_api_key, settings.api_key):
        return AuthContext(organization_id=x_lz_organization or "default", key_id="bootstrap")
    raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="invalid API key")


def sign_webhook(secret: str, timestamp: int, payload: bytes) -> str:
    signed = f"{timestamp}.".encode() + payload
    digest = hmac.new(secret.encode(), signed, hashlib.sha256).hexdigest()
    return f"v1={digest}"


def verify_webhook(secret: str, timestamp: int, payload: bytes, signature: str) -> bool:
    age = abs(int(datetime.now(UTC).timestamp()) - timestamp)
    if age > settings.webhook_tolerance_seconds:
        return False
    expected = sign_webhook(secret, timestamp, payload)
    return hmac.compare_digest(expected, signature)
