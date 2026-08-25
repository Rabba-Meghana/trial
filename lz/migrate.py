from __future__ import annotations

from sqlalchemy import text

from .db import Base, engine
from .security import ApiKeyRow

ALTERATIONS = (
    "ALTER TABLE obligations ADD COLUMN IF NOT EXISTS organization_id VARCHAR(64) NOT NULL DEFAULT 'default'",
    "ALTER TABLE capacity_orders ADD COLUMN IF NOT EXISTS organization_id VARCHAR(64) NOT NULL DEFAULT 'default'",
    "ALTER TABLE journal_postings ADD COLUMN IF NOT EXISTS organization_id VARCHAR(64) NOT NULL DEFAULT 'default'",
    "ALTER TABLE risk_limits ADD COLUMN IF NOT EXISTS reserved_minor BIGINT NOT NULL DEFAULT 0",
    "ALTER TABLE transfers ADD COLUMN IF NOT EXISTS participant_id VARCHAR(64) NOT NULL DEFAULT ''",
    "ALTER TABLE transfers ADD COLUMN IF NOT EXISTS reserved_minor BIGINT NOT NULL DEFAULT 0",
    "ALTER TABLE webhook_events ADD COLUMN IF NOT EXISTS attempts INTEGER NOT NULL DEFAULT 0",
    "ALTER TABLE webhook_events ADD COLUMN IF NOT EXISTS next_attempt_at TIMESTAMPTZ NOT NULL DEFAULT NOW()",
    "ALTER TABLE webhook_events ADD COLUMN IF NOT EXISTS last_error VARCHAR(1000) NOT NULL DEFAULT ''",
    "CREATE INDEX IF NOT EXISTS ix_obligations_organization_id ON obligations (organization_id)",
    "CREATE INDEX IF NOT EXISTS ix_capacity_orders_organization_id ON capacity_orders (organization_id)",
    "CREATE INDEX IF NOT EXISTS ix_journal_postings_organization_id ON journal_postings (organization_id)",
    "CREATE INDEX IF NOT EXISTS ix_transfers_participant_id ON transfers (participant_id)",
)


def migrate() -> None:
    if ApiKeyRow.__tablename__ != "api_keys":
        raise RuntimeError("API key model registration failed")
    Base.metadata.create_all(bind=engine)
    with engine.begin() as connection:
        for statement in ALTERATIONS:
            connection.execute(text(statement))


if __name__ == "__main__":
    migrate()
