from __future__ import annotations

import hashlib
import hmac
import secrets
from dataclasses import dataclass
from datetime import UTC, datetime
from typing import Annotated

from fastapi import Header, HTTPException, status
from sqlalchemy import BigInteger, DateTime, Integer, String, delete, select
from sqlalchemy.dialects.postgresql import insert
from sqlalchemy.orm import Mapped, mapped_column

from .config import settings
from .db import Base, SessionLocal


def _utcnow() -> datetime:
    return datetime.now(UTC)


class ApiKeyRow(Base):
    __tablename__ = "api_keys"

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    organization_id: Mapped[str] = mapped_column(String(64), index=True)
    key_hash: Mapped[str] = mapped_column(String(64), unique=True, index=True)
    prefix: Mapped[str] = mapped_column(String(24), index=True)
    status: Mapped[str] = mapped_column(String(32), default="active", index=True)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=_utcnow)


class ApiRateLimitRow(Base):
    __tablename__ = "api_rate_limits"

    id: Mapped[str] = mapped_column(String(160), primary_key=True)
    key_id: Mapped[str] = mapped_column(String(64), index=True)
    window_epoch_minute: Mapped[int] = mapped_column(BigInteger, index=True)
    request_count: Mapped[int] = mapped_column(Integer, default=0)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=_utcnow)


@dataclass(frozen=True, slots=True)
class AuthContext:
    organization_id: str
    key_id: str


def hash_api_key(raw_key: str) -> str:
    return hashlib.sha256(raw_key.encode("utf-8")).hexdigest()


def issue_api_key(organization_id: str) -> tuple[str, ApiKeyRow]:
    raw_key = f"lz_live_{secrets.token_urlsafe(32)}"
    row = ApiKeyRow(
        id=f"key_{secrets.token_hex(12)}",
        organization_id=organization_id,
        key_hash=hash_api_key(raw_key),
        prefix=raw_key[:16],
    )
    return raw_key, row


def rotate_api_key(organization_id: str, current_key_id: str) -> tuple[str, str]:
    raw_key, new_row = issue_api_key(organization_id)
    with SessionLocal.begin() as session:
        current = session.get(ApiKeyRow, current_key_id)
        if current is None or current.organization_id != organization_id:
            raise ValueError("API key not found")
        if current.status != "active":
            raise ValueError("API key is not active")
        current.status = "revoked"
        session.add(new_row)
    return raw_key, new_row.id


def revoke_api_key(organization_id: str, key_id: str) -> None:
    with SessionLocal.begin() as session:
        row = session.get(ApiKeyRow, key_id)
        if row is None or row.organization_id != organization_id:
            raise ValueError("API key not found")
        row.status = "revoked"


def _enforce_rate_limit(key_id: str, per_minute: int) -> None:
    if per_minute <= 0:
        return
    window = int(datetime.now(UTC).timestamp()) // 60
    bucket_id = f"{key_id}:{window}"
    statement = (
        insert(ApiRateLimitRow)
        .values(
            id=bucket_id,
            key_id=key_id,
            window_epoch_minute=window,
            request_count=1,
        )
        .on_conflict_do_update(
            index_elements=[ApiRateLimitRow.id],
            set_={"request_count": ApiRateLimitRow.request_count + 1},
        )
        .returning(ApiRateLimitRow.request_count)
    )
    with SessionLocal.begin() as session:
        count = session.scalar(statement)
        if count is None:
            raise RuntimeError("rate-limit counter update returned no value")
        if count > per_minute:
            raise HTTPException(
                status_code=status.HTTP_429_TOO_MANY_REQUESTS,
                detail="API rate limit exceeded",
                headers={"Retry-After": "60"},
            )


def cleanup_rate_limit_buckets(retain_minutes: int = 10) -> int:
    if retain_minutes < 1:
        raise ValueError("retain_minutes must be positive")
    current_window = int(datetime.now(UTC).timestamp()) // 60
    cutoff = current_window - retain_minutes
    with SessionLocal.begin() as session:
        result = session.execute(
            delete(ApiRateLimitRow).where(ApiRateLimitRow.window_epoch_minute < cutoff)
        )
        return int(result.rowcount or 0)


def require_auth(
    x_api_key: Annotated[str, Header()],
    x_lz_organization: Annotated[str | None, Header()] = None,
) -> AuthContext:
    digest = hash_api_key(x_api_key)
    with SessionLocal() as session:
        row = session.scalar(
            select(ApiKeyRow).where(ApiKeyRow.key_hash == digest).where(ApiKeyRow.status == "active")
        )
        if row is not None:
            context = AuthContext(organization_id=row.organization_id, key_id=row.id)
            _enforce_rate_limit(context.key_id, settings.tenant_rate_limit_per_minute)
            return context
    if settings.environment != "production" and secrets.compare_digest(x_api_key, settings.api_key):
        context = AuthContext(organization_id=x_lz_organization or "default", key_id="bootstrap")
        _enforce_rate_limit(context.key_id, settings.tenant_rate_limit_per_minute)
        return context
    raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="invalid API key")


def require_admin(x_api_key: Annotated[str, Header()]) -> None:
    if not secrets.compare_digest(x_api_key, settings.api_key):
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="invalid admin API key")
    _enforce_rate_limit("admin", settings.admin_rate_limit_per_minute)


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
