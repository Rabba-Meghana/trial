from __future__ import annotations

import argparse

from sqlalchemy import select

from .db import OrganizationRow, SessionLocal, init_db
from .security import ApiKeyRow, issue_api_key


def provision(organization_id: str, name: str) -> str:
    init_db()
    with SessionLocal.begin() as session:
        organization = session.get(OrganizationRow, organization_id)
        if organization is None:
            organization = OrganizationRow(id=organization_id, name=name)
            session.add(organization)
        existing = session.scalar(
            select(ApiKeyRow)
            .where(ApiKeyRow.organization_id == organization_id)
            .where(ApiKeyRow.status == "active")
        )
        if existing is not None:
            raise RuntimeError("organization already has an active API key; rotate explicitly")
        raw_key, key_row = issue_api_key(organization_id)
        session.add(key_row)
        return raw_key


def main() -> None:
    parser = argparse.ArgumentParser(description="Provision a Liquidity Zero tenant")
    parser.add_argument("organization_id")
    parser.add_argument("name")
    args = parser.parse_args()
    raw_key = provision(args.organization_id, args.name)
    print(raw_key)


if __name__ == "__main__":
    main()
