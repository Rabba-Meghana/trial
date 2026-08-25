from pydantic import model_validator
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_prefix="LZ_", env_file=".env", extra="ignore")

    environment: str = "development"
    api_key: str = "dev-only-change-me"
    database_url: str = "postgresql+psycopg://lz:lz@postgres:5432/lz"
    webhook_secret: str = "dev-webhook-secret-change-me"
    webhook_tolerance_seconds: int = 300
    public_base_url: str = "http://localhost:8080"
    tenant_rate_limit_per_minute: int = 600
    admin_rate_limit_per_minute: int = 120

    @model_validator(mode="after")
    def validate_production_secrets(self) -> "Settings":
        if self.environment.lower() != "production":
            return self
        insecure: list[str] = []
        if self.api_key == "dev-only-change-me" or len(self.api_key) < 32:
            insecure.append("LZ_API_KEY")
        if self.webhook_secret == "dev-webhook-secret-change-me" or len(self.webhook_secret) < 32:
            insecure.append("LZ_WEBHOOK_SECRET")
        if self.database_url == "postgresql+psycopg://lz:lz@postgres:5432/lz":
            insecure.append("LZ_DATABASE_URL")
        if not self.public_base_url.startswith("https://"):
            insecure.append("LZ_PUBLIC_BASE_URL")
        if insecure:
            joined = ", ".join(insecure)
            raise ValueError(f"production configuration contains insecure defaults: {joined}")
        return self


settings = Settings()
