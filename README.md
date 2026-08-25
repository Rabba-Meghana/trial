# Liquidity Zero

Liquidity Zero is a directly integratable settlement-capacity exchange runtime and SDK. It provides tenant-scoped infrastructure for participant onboarding, collateral and credit controls, obligation netting, settlement-capacity matching, idempotent transfers, reconciliation, auditability, and signed event delivery.

Current release: **v0.3.0**.

This repository is a real sandbox integration runtime. It does **not** claim live connectivity to FedNow, RTP, ACH operators, SWIFT, banks, custodians, or regulated liquidity providers. Production rail adapters require actual credentials, contractual access, security review, and the appropriate legal/regulatory structure.

## What is implemented

- Integer minor-unit monetary representation; binary floating point is forbidden in financial-domain amounts.
- Per-currency double-entry conservation rules.
- Multilateral obligation netting with value conservation.
- Settlement-capacity order book with partial fills, price-time priority, settlement windows, and self-trade prevention.
- PostgreSQL row locking for market clearing.
- Tenant API keys generated as `lz_live_*`, SHA-256 hashed at rest, organization-bound, rotatable, and revocable.
- Participant-specific collateral, credit, reservation, and single-transfer limits.
- Atomic settlement-capacity reservation using `SELECT ... FOR UPDATE` before transfer execution.
- Explicit transfer lifecycle including `reserved`, provider-accepted state, `settled`, and `failed`.
- Capacity release on provider failure or settlement.
- Idempotent transfer handling per organization.
- Reconciliation of expected versus observed amounts.
- Append-only audit events for sensitive financial and configuration operations.
- Durable webhook outbox using `FOR UPDATE SKIP LOCKED`, exponential retry, and dead-letter state.
- Dedicated outbox worker service.
- HMAC-SHA256 signed webhooks with timestamp replay protection.
- Python SDK.
- TypeScript SDK with webhook verification helper.
- Connector certification tests for future rail/provider adapters.
- Idempotent schema migrations.
- Docker API, PostgreSQL, and worker deployment.
- Six independent CI gates: package, Ruff, strict mypy, PostgreSQL tests, TypeScript build/typecheck, and Docker build.

## Quick start

```bash
docker compose up --build
```

API: `http://localhost:8080`

- Health: `GET /healthz`
- OpenAPI: `GET /openapi.json`
- Interactive docs: `GET /docs`

## Provision a tenant

The operator secret is supplied through `LZ_API_KEY`.

```bash
python -m lz.provision acme-fintech "Acme Fintech"
```

Or:

```http
POST /v1/admin/organizations
X-API-Key: <operator-key>
Content-Type: application/json

{
  "id": "acme-fintech",
  "name": "Acme Fintech"
}
```

The raw tenant API key is returned once. Only its SHA-256 hash is stored.

## Python SDK

```python
from lz import LiquidityZeroClient

lz = LiquidityZeroClient(
    api_key="lz_live_...",
    organization_id="acme-fintech",
    base_url="https://api.example.com",
)

participant = lz.create_participant(
    external_id="merchant_123",
    legal_name="Example Merchant LLC",
)

lz.set_risk_limit(
    participant_id=participant["id"],
    currency="USD",
    credit_limit_minor=5_000_000,
    collateral_minor=2_000_000,
    max_single_transfer_minor=1_000_000,
)

transfer = lz.create_transfer(
    participant_id=participant["id"],
    amount_minor=250_000,
    currency="USD",
    source_account="wallet:merchant_123",
    destination_account="bank:beneficiary_001",
    idempotency_key="payout_20260823_000001",
)
```

All monetary values are integer minor units. For USD, `100` means `$1.00`.

The current transfer connector identifies itself as `sandbox`; no response claims real funds moved.

## TypeScript SDK

The TypeScript SDK lives under `sdk/typescript` and is built as `@liquidity-zero/sdk`.

```ts
import { LiquidityZeroClient, verifyWebhook } from "@liquidity-zero/sdk";

const lz = new LiquidityZeroClient({
  apiKey: "lz_live_...",
  organizationId: "acme-fintech",
  baseUrl: "https://api.example.com",
});

const participant = await lz.createParticipant({
  external_id: "merchant_123",
  legal_name: "Example Merchant LLC",
});
```

## Atomic capacity reservation

A transfer does not merely check capacity. The API locks the participant/currency risk row and reserves capacity inside the database transaction.

```text
available = credit_limit + collateral - reserved

requested <= max_single_transfer
requested <= available
```

If valid:

```text
lock risk row
  -> increment reserved
  -> persist transfer intent
  -> commit reservation
  -> submit to connector
  -> persist provider state
  -> enqueue event
```

If connector submission fails, the reservation is released and the transfer is marked failed. When settlement is finalized, the reservation is released atomically.

The test suite includes a concurrent race where two 700-unit transfers compete against only 1,000 units of capacity. Exactly one succeeds and the other is rejected.

## API-key lifecycle

Rotate the current tenant key:

```http
POST /v1/api-keys/rotate
X-API-Key: <current-tenant-key>
```

The previous key is revoked as the new key is created.

Operators can revoke a key explicitly:

```http
DELETE /v1/admin/organizations/{organization_id}/api-keys/{key_id}
X-API-Key: <operator-key>
```

## Webhooks and durable outbox

Customer endpoints are registered with:

```http
POST /v1/webhook-endpoints
```

Events include transfer, reconciliation, API-key, and integration events. Webhooks use:

```text
X-LZ-Timestamp
X-LZ-Signature: v1=<hmac-sha256>
X-LZ-Event-ID
```

The signed input is:

```text
<timestamp>.<raw-request-body>
```

Webhook events are persisted before delivery. The worker claims pending events with `FOR UPDATE SKIP LOCKED`, retries failures with exponential backoff, and moves exhausted deliveries to `dead_letter`.

`docker compose up --build` starts both the API and `outbox-worker`.

## Main customer API

- `POST /v1/participants`
- `PUT /v1/participants/{participant_id}/risk-limit`
- `POST /v1/obligations`
- `GET /v1/netting/{currency}`
- `POST /v1/capacity/orders`
- `POST /v1/transfers`
- `GET /v1/transfers/{transfer_id}`
- `POST /v1/reconciliation`
- `POST /v1/webhook-endpoints`
- `POST /v1/webhook-endpoints/{endpoint_id}/test`
- `POST /v1/api-keys/rotate`

Operator-only endpoints include tenant provisioning, global capacity clearing, transfer-settlement simulation, key revocation, and manual outbox delivery.

## Financial invariants

```text
sum(journal postings per currency) = 0
sum(net positions per closed currency set) = 0
filled_amount(order) <= remaining_amount(order)
reserved_capacity >= 0
reserved_capacity <= credit_limit + collateral
transfer amount <= max_single_transfer
```

These are execution constraints, not dashboard warnings.

## CI verification

GitHub Actions independently runs:

```text
Python package build + compile
Ruff
mypy --strict
PostgreSQL-backed pytest suite
TypeScript SDK typecheck + build
Docker production image build
```

The PostgreSQL suite includes idempotency, over-limit rejection, reservation release, API-key rotation, integration-contract coverage, connector certification, and concurrent capacity-race testing.

## Production configuration

At minimum:

```text
LZ_ENVIRONMENT=production
LZ_DATABASE_URL=postgresql+psycopg://...
LZ_API_KEY=<strong-operator-secret>
LZ_WEBHOOK_TOLERANCE_SECONDS=300
LZ_PUBLIC_BASE_URL=https://api.example.com
```

Do not use repository development secrets in production.

## Production boundary

v0.3 is suitable for sandbox pilots, architecture evaluation, partner integration testing, and development against the real API/SDK contract. It is not yet a regulated live-money network.

Before enabling real funds, the remaining external/organizational requirements include:

- a contracted bank, BaaS, payment-network, or regulated stablecoin/settlement provider
- certified production adapters using actual provider credentials
- KYB/KYC/AML/sanctions controls appropriate to the operating model
- legally enforceable collateral/credit arrangements
- production KMS/HSM-backed secret management
- granular operator RBAC and approval policies
- independent settlement-finality ingestion and bank/rail reconciliation
- production rate limiting, WAF, monitoring, alerting, and incident runbooks
- penetration testing and security review
- jurisdiction-specific legal and regulatory analysis

The repository deliberately keeps this boundary explicit rather than fabricating regulated connectivity.
