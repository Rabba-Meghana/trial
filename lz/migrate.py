from __future__ import annotations

from sqlalchemy import text

from .db import Base, engine
from .security import ApiKeyRow


ALTERATIONS = (
    "ALTER TABLE obligations ADD COLUMN IF NOT EXISTS organization_id VARCHAR(64) NOT NULL DEFAULT 'default'",
    "ALTER TABLE capacity_orders ADD COLUMN IF NOT EXISTS organization_id VARCHAR(64) NOT NULL DEFAULT 'default'",
    "ALTER TABLE journal_postings ADD COLUMN IF NOT EXISTS organization_id VARCHAR(64) NOT NULL DEFAULT 'default'",
    "CREATE INDEX IF NOT EXISTS ix_obligations_organization_id ON obligations (organization_id)",
    "CREATE INDEX IF NOT EXISTS ix_capacity_orders_organization_id ON capacity_orders (organization_id)",
    "CREATE INDEX IF NOT EXISTS ix_journal_postings_organization_id ON journal_postings (organization_id)",
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
