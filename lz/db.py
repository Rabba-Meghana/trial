from __future__ import annotations

from datetime import UTC, datetime
from uuid import uuid4

from sqlalchemy import BigInteger, DateTime, Integer, String, UniqueConstraint, create_engine
from sqlalchemy.orm import DeclarativeBase, Mapped, Session, mapped_column, sessionmaker

from .config import settings


def _utcnow() -> datetime:
    return datetime.now(UTC)


class Base(DeclarativeBase):
    pass


class OrganizationRow(Base):
    __tablename__ = "organizations"

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    name: Mapped[str] = mapped_column(String(160))
    status: Mapped[str] = mapped_column(String(32), default="active", index=True)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=_utcnow)


class ParticipantRow(Base):
    __tablename__ = "participants"
    __table_args__ = (
        UniqueConstraint("organization_id", "external_id", name="uq_org_participant"),
    )

    id: Mapped[str] = mapped_column(
        String(64), primary_key=True, default=lambda: f"pt_{uuid4().hex}"
    )
    organization_id: Mapped[str] = mapped_column(String(64), index=True)
    external_id: Mapped[str] = mapped_column(String(128), index=True)
    legal_name: Mapped[str] = mapped_column(String(200))
    status: Mapped[str] = mapped_column(String(32), default="active", index=True)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=_utcnow)


class RiskLimitRow(Base):
    __tablename__ = "risk_limits"
    __table_args__ = (
        UniqueConstraint(
            "organization_id", "participant_id", "currency", name="uq_risk_limit"
        ),
    )

    id: Mapped[str] = mapped_column(
        String(64), primary_key=True, default=lambda: f"rl_{uuid4().hex}"
    )
    organization_id: Mapped[str] = mapped_column(String(64), index=True)
    participant_id: Mapped[str] = mapped_column(String(64), index=True)
    currency: Mapped[str] = mapped_column(String(16), index=True)
    credit_limit_minor: Mapped[int] = mapped_column(BigInteger, default=0)
    collateral_minor: Mapped[int] = mapped_column(BigInteger, default=0)
    reserved_minor: Mapped[int] = mapped_column(BigInteger, default=0)
    max_single_transfer_minor: Mapped[int] = mapped_column(BigInteger, default=0)
    updated_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), default=_utcnow, onupdate=_utcnow
    )


class ObligationRow(Base):
    __tablename__ = "obligations"

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    organization_id: Mapped[str] = mapped_column(String(64), default="default", index=True)
    payer: Mapped[str] = mapped_column(String(128), index=True)
    payee: Mapped[str] = mapped_column(String(128), index=True)
    currency: Mapped[str] = mapped_column(String(16), index=True)
    amount_minor: Mapped[int] = mapped_column(BigInteger)
    due_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), index=True)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=_utcnow)


class CapacityOrderRow(Base):
    __tablename__ = "capacity_orders"

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    organization_id: Mapped[str] = mapped_column(String(64), default="default", index=True)
    participant: Mapped[str] = mapped_column(String(128), index=True)
    side: Mapped[str] = mapped_column(String(8), index=True)
    currency: Mapped[str] = mapped_column(String(16), index=True)
    amount_minor: Mapped[int] = mapped_column(BigInteger)
    remaining_minor: Mapped[int] = mapped_column(BigInteger)
    price_bps: Mapped[int] = mapped_column(Integer)
    window_start: Mapped[datetime] = mapped_column(DateTime(timezone=True), index=True)
    window_end: Mapped[datetime] = mapped_column(DateTime(timezone=True), index=True)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=_utcnow)


class JournalPostingRow(Base):
    __tablename__ = "journal_postings"
    __table_args__ = (UniqueConstraint("entry_id", "line_no", name="uq_entry_line"),)

    id: Mapped[str] = mapped_column(String(64), primary_key=True, default=lambda: uuid4().hex)
    organization_id: Mapped[str] = mapped_column(String(64), default="default", index=True)
    entry_id: Mapped[str] = mapped_column(String(64), index=True)
    line_no: Mapped[int] = mapped_column(Integer)
    account: Mapped[str] = mapped_column(String(160), index=True)
    currency: Mapped[str] = mapped_column(String(16), index=True)
    amount_minor: Mapped[int] = mapped_column(BigInteger)
    reference: Mapped[str] = mapped_column(String(256))
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=_utcnow)


class TransferRow(Base):
    __tablename__ = "transfers"
    __table_args__ = (
        UniqueConstraint("organization_id", "idempotency_key", name="uq_transfer_idem"),
    )

    id: Mapped[str] = mapped_column(
        String(64), primary_key=True, default=lambda: f"tr_{uuid4().hex}"
    )
    organization_id: Mapped[str] = mapped_column(String(64), index=True)
    participant_id: Mapped[str] = mapped_column(String(64), default="", index=True)
    idempotency_key: Mapped[str] = mapped_column(String(128))
    connector: Mapped[str] = mapped_column(String(64), index=True)
    provider_transfer_id: Mapped[str] = mapped_column(String(128), index=True)
    state: Mapped[str] = mapped_column(String(32), index=True)
    amount_minor: Mapped[int] = mapped_column(BigInteger)
    currency: Mapped[str] = mapped_column(String(16), index=True)
    source_account: Mapped[str] = mapped_column(String(160))
    destination_account: Mapped[str] = mapped_column(String(160))
    reserved_minor: Mapped[int] = mapped_column(BigInteger, default=0)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=_utcnow)
    updated_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), default=_utcnow, onupdate=_utcnow
    )


class ReconciliationRow(Base):
    __tablename__ = "reconciliation_items"
    __table_args__ = (
        UniqueConstraint("organization_id", "external_reference", name="uq_recon_ref"),
    )

    id: Mapped[str] = mapped_column(
        String(64), primary_key=True, default=lambda: f"rec_{uuid4().hex}"
    )
    organization_id: Mapped[str] = mapped_column(String(64), index=True)
    external_reference: Mapped[str] = mapped_column(String(160), index=True)
    currency: Mapped[str] = mapped_column(String(16), index=True)
    expected_minor: Mapped[int] = mapped_column(BigInteger)
    observed_minor: Mapped[int] = mapped_column(BigInteger)
    status: Mapped[str] = mapped_column(String(32), index=True)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=_utcnow)


class WebhookEndpointRow(Base):
    __tablename__ = "webhook_endpoints"

    id: Mapped[str] = mapped_column(
        String(64), primary_key=True, default=lambda: f"wh_{uuid4().hex}"
    )
    organization_id: Mapped[str] = mapped_column(String(64), index=True)
    url: Mapped[str] = mapped_column(String(512))
    secret: Mapped[str] = mapped_column(String(256))
    status: Mapped[str] = mapped_column(String(32), default="active", index=True)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=_utcnow)


class WebhookEventRow(Base):
    __tablename__ = "webhook_events"

    id: Mapped[str] = mapped_column(
        String(64), primary_key=True, default=lambda: f"evt_{uuid4().hex}"
    )
    organization_id: Mapped[str] = mapped_column(String(64), index=True)
    event_type: Mapped[str] = mapped_column(String(128), index=True)
    payload_json: Mapped[str] = mapped_column(String(8000))
    delivery_status: Mapped[str] = mapped_column(String(32), default="pending", index=True)
    attempts: Mapped[int] = mapped_column(Integer, default=0)
    next_attempt_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=_utcnow)
    last_error: Mapped[str] = mapped_column(String(1000), default="")
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=_utcnow)


class AuditEventRow(Base):
    __tablename__ = "audit_events"

    id: Mapped[str] = mapped_column(
        String(64), primary_key=True, default=lambda: f"aud_{uuid4().hex}"
    )
    organization_id: Mapped[str] = mapped_column(String(64), index=True)
    actor_key_id: Mapped[str] = mapped_column(String(64), index=True)
    action: Mapped[str] = mapped_column(String(128), index=True)
    resource_type: Mapped[str] = mapped_column(String(64), index=True)
    resource_id: Mapped[str] = mapped_column(String(128), index=True)
    payload_json: Mapped[str] = mapped_column(String(8000), default="{}")
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=_utcnow)


engine = create_engine(settings.database_url, pool_pre_ping=True)
SessionLocal: sessionmaker[Session] = sessionmaker(bind=engine, expire_on_commit=False)


def init_db() -> None:
    Base.metadata.create_all(bind=engine)
