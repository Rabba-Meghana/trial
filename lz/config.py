from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_prefix="LZ_", env_file=".env", extra="ignore")

    environment: str = "development"
    api_key: str = "dev-only-change-me"
    database_url: str = "postgresql+psycopg://lz:lz@postgres:5432/lz"


settings = Settings()
