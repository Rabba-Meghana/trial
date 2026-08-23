from __future__ import annotations

from datetime import datetime
from uuid import uuid4

from sqlalchemy import BigInteger, DateTime, Integer, String, UniqueConstraint, create_engine
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, sessionmaker

from .config import settings


class Base(DeclarativeBase):
    pass


class ObligationRow(Base):
    __tablename__ = "obligations"

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    payer: Mapped[str] = mapped_column(String(128), index=True)
    payee: Mapped[str] = mapped_column(String(128), index=True)
    currency: Mapped[str] = mapped_column(String(16), index=True)
    amount_minor: Mapped[int] = mapped_column(BigInteger)
    due_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), index=True)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=datetime.utcnow)


class CapacityOrderRow(Base):
    __tablename__ = "capacity_orders"

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    participant: Mapped[str] = mapped_column(String(128), index=True)
    side: Mapped[str] = mapped_column(String(8), index=True)
    currency: Mapped[str] = mapped_column(String(16), index=True)
    amount_minor: Mapped[int] = mapped_column(BigInteger)
    remaining_minor: Mapped[int] = mapped_column(BigInteger)
    price_bps: Mapped[int] = mapped_column(Integer)
    window_start: Mapped[datetime] = mapped_column(DateTime(timezone=True), index=True)
    window_end: Mapped[datetime] = mapped_column(DateTime(timezone=True), index=True)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=datetime.utcnow)


class JournalPostingRow(Base):
    __tablename__ = "journal_postings"
    __table_args__ = (UniqueConstraint("entry_id", "line_no", name="uq_entry_line"),)

    id: Mapped[str] = mapped_column(String(64), primary_key=True, default=lambda: uuid4().hex)
    entry_id: Mapped[str] = mapped_column(String(64), index=True)
    line_no: Mapped[int] = mapped_column(Integer)
    account: Mapped[str] = mapped_column(String(160), index=True)
    currency: Mapped[str] = mapped_column(String(16), index=True)
    amount_minor: Mapped[int] = mapped_column(BigInteger)
    reference: Mapped[str] = mapped_column(String(256))
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=datetime.utcnow)


engine = create_engine(settings.database_url, pool_pre_ping=True)
SessionLocal = sessionmaker(bind=engine, expire_on_commit=False)


def init_db() -> None:
    Base.metadata.create_all(bind=engine)
