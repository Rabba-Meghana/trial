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


settings = Settings()
