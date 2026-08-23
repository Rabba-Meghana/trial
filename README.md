# Liquidity Zero

Liquidity Zero is an early settlement-capacity exchange runtime. The first release focuses on the hard financial primitives rather than a marketing dashboard: immutable double-entry rules, multilateral obligation netting, a settlement-capacity order book, deterministic matching, and constrained liquidity routing.

## What is real in this repository

- Monetary values are represented as integer minor units; binary floating-point is forbidden in the financial domain.
- Journal entries must balance independently per currency or creation fails.
- Obligation netting is value-conserving per currency and rejects duplicate obligation identifiers.
- Capacity orders support partial fills, price-time priority, settlement windows, and self-trade prevention.
- PostgreSQL-backed market clearing locks open order rows before decrementing remaining capacity.
- API requests use stable idempotency-derived identifiers.
- Liquidity routing enforces capacity, latency, and risk constraints.
- Hypothesis property tests exercise conservation across generated obligation sets.

This repository does **not** claim connection to FedNow, RTP, ACH operators, SWIFT, banks, or custodians. Those require formal partner integrations, security review, and potentially regulatory/licensing work. Provider sandboxes and production connectors must remain explicitly distinguished.

## Run locally

```bash
docker compose up --build
```

The API listens on `http://localhost:8080`. Interactive OpenAPI documentation is available at `/docs`.

Health check:

```bash
curl http://localhost:8080/healthz
```

Authenticated example:

```bash
curl -X POST http://localhost:8080/v1/obligations \
  -H 'Content-Type: application/json' \
  -H 'X-API-Key: local-dev-key-change-me' \
  -d '{
    "payer":"fintech-a",
    "payee":"fintech-b",
    "currency":"USD",
    "amount_minor":5000000,
    "due_at":"2026-08-24T14:00:00Z",
    "idempotency_key":"demo-obligation-0001"
  }'
```

Net the USD obligation graph:

```bash
curl http://localhost:8080/v1/netting/USD \
  -H 'X-API-Key: local-dev-key-change-me'
```

## API surface

- `GET /healthz`
- `POST /v1/obligations`
- `GET /v1/netting/{currency}`
- `POST /v1/capacity/orders`
- `POST /v1/capacity/clear/{currency}`

## Financial invariants

For every journal entry and currency:

`sum(postings) = 0`

For every closed netting set and currency:

`sum(net_positions) = 0`

For every market clearing operation:

`filled_amount(order) <= remaining_amount(order)`

These are execution constraints, not monitoring rules.

## Current boundary

This is the launchable technical kernel, not yet a regulated settlement network. Before real funds can move, the project still needs external-rail adapters, a proper migration process, key management, participant onboarding/KYB, permissions, collateral and credit controls, reconciliation against independent source-of-truth statements, operational runbooks, penetration testing, legal structure, and bank/network partnerships.

## Development

```bash
python -m venv .venv
source .venv/bin/activate
pip install -e '.[dev]'
pytest
ruff check .
mypy lz
```
