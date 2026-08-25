from __future__ import annotations

import pytest
from pydantic import ValidationError

from lz.config import Settings


def test_production_rejects_development_defaults() -> None:
    with pytest.raises(ValidationError, match="production configuration contains insecure defaults"):
        Settings(environment="production")


def test_production_accepts_explicit_secure_configuration() -> None:
    configured = Settings(
        environment="production",
        api_key="a" * 48,
        webhook_secret="b" * 48,
        database_url="postgresql+psycopg://secure:secret@db.internal:5432/lz",
        public_base_url="https://api.liquidity-zero.example",
    )

    assert configured.environment == "production"
    assert configured.public_base_url.startswith("https://")
