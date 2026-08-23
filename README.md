# Liquidity Zero

Liquidity Zero is a directly integratable settlement-capacity exchange runtime and SDK. It provides tenant-scoped financial infrastructure for participant onboarding, risk and collateral limits, obligation netting, a settlement-capacity order book, deterministic matching, constrained liquidity routing, idempotent transfers, reconciliation, and signed webhooks.

The current release is a real sandbox integration runtime. It does not claim live connectivity to FedNow, RTP, ACH operators, SWIFT, banks, custodians, or regulated liquidity providers. Production rail adapters require actual provider credentials, legal agreements, security review, and the appropriate regulatory structure.

## What is real

- Monetary values use integer minor units; binary floating-point is forbidden in the financial domain.
- Journal entries must balance independently per currency or creation fails.
- Obligation netting conserves value per currency and rejects duplicate obligation identifiers.
- Capacity orders support partial fills, price-time priority, settlement windows, and self-trade prevention.
- PostgreSQL market clearing locks open order rows before decrementing capacity.
- Tenant API keys are generated as `lz_live_*`, bound to one organization, and SHA-256 hashed at rest.
- Transfers are idempotent per organization.
- Transfer execution enforces participant ownership, configured credit/collateral capacity, and single-transfer limits.
- Reconciliation records independently compare expected and observed amounts.
- Outbound webhooks are HMAC-SHA256 signed with timestamp replay protection support.
- The Docker image applies idempotent schema migrations before starting the API.
- A Python SDK ships in the same package.
- CI gates package installation, Ruff, strict mypy, PostgreSQL-backed tests, and the production Docker build.

## Quick start

Start PostgreSQL and the API:

```bash
docker compose up --build
```

The service listens on `http://localhost:8080`.

- Health: `GET /healthz`
- OpenAPI JSON: `GET /openapi.json`
- Interactive API docs: `GET /docs`

## Provision a fintech tenant

The service has an operator/admin key configured through `LZ_API_KEY`. In development, create a tenant with the CLI:

```bash
python -m lz.provision acme-fintech "Acme Fintech"
```

The command prints a tenant API key once:

```text
lz_live_...
```

Only the SHA-256 hash is stored in PostgreSQL. Treat the raw key as a secret.

An operator can also provision a tenant through:

```http
POST /v1/admin/organizations
X-API-Key: <operator-key>
```

```json
{
  "id": "acme-fintech",
  "name": "Acme Fintech"
}
```

The response contains the newly generated tenant key once.

## Python SDK integration

Install the package from the repository/build artifact:

```bash
pip install .
```

Then initialize the client using the `lz` import namespace:

```python
from lz import LiquidityZeroClient

lz = LiquidityZeroClient(
    api_key="lz_live_...",
    organization_id="acme-fintech",
    base_url="https://your-liquidity-zero-host.example",
)
```

### 1. Onboard a participant

```python
participant = lz.create_participant(
    external_id="merchant_123",
    legal_name="Example Merchant LLC",
)
```

### 2. Configure settlement capacity controls

```python
lz.set_risk_limit(
    participant_id=participant["id"],
    currency="USD",
    credit_limit_minor=5_000_000,
    collateral_minor=2_000_000,
    max_single_transfer_minor=1_000_000,
)
```

All values are integer minor units. For USD, `100` means `$1.00`.

### 3. Submit an idempotent transfer

```python
transfer = lz.create_transfer(
    participant_id=participant["id"],
    amount_minor=250_000,
    currency="USD",
    source_account="wallet:merchant_123",
    destination_account="bank:beneficiary_001",
    idempotency_key="payout_20260823_000001",
)
```

Submitting the same organization + idempotency key again returns the same stored transfer instead of creating a second one.

The current connector is `sandbox`; the response never pretends real funds moved.

### 4. Record obligations and calculate net positions

```python
from datetime import UTC, datetime

lz.create_obligation(
    payer="merchant_123",
    payee="merchant_456",
    currency="USD",
    amount_minor=500_000,
    due_at=datetime.now(UTC),
    idempotency_key="obligation_000001",
)

positions = lz.netting("USD")
```

### 5. Submit settlement-capacity orders

```python
from datetime import UTC, datetime, timedelta

start = datetime.now(UTC)

lz.create_capacity_order(
    participant="merchant_123",
    side="buy",
    currency="USD",
    amount_minor=1_000_000,
    price_bps=25,
    window_start=start,
    window_end=start + timedelta(hours=1),
    idempotency_key="capacity_000001",
)
```

Market clearing is an operator-only action:

```http
POST /v1/admin/capacity/clear/USD
X-API-Key: <operator-key>
```

This separation prevents customers from unilaterally triggering global clearing.

### 6. Reconcile an external statement line

```python
result = lz.reconcile(
    external_reference="bank-statement-line-82911",
    currency="USD",
    expected_minor=250_000,
    observed_minor=249_900,
)

assert result["status"] == "mismatch"
assert result["delta_minor"] == -100
```

## Webhooks

Register a customer endpoint:

```python
endpoint = lz.create_webhook_endpoint(
    url="https://fintech.example.com/webhooks/liquidity-zero",
    secret="replace-with-a-long-random-secret",
)
```

Liquidity Zero emits events such as:

- `transfer.accepted`
- `reconciliation.matched`
- `reconciliation.mismatch`
- `integration.test`

Outbound requests include:

```text
X-LZ-Timestamp: <unix-seconds>
X-LZ-Signature: v1=<hmac-sha256>
X-LZ-Event-ID: evt_...
```

The signed message is:

```text
<timestamp>.<raw-request-body>
```

Verify using the exact raw body before JSON parsing:

```python
from lz.security import verify_webhook

valid = verify_webhook(
    secret="replace-with-a-long-random-secret",
    timestamp=int(request.headers["X-LZ-Timestamp"]),
    payload=request.body,
    signature=request.headers["X-LZ-Signature"],
)
```

Webhook delivery currently retries synchronously up to three attempts. A durable outbox/queue with exponential backoff and dead-letter handling is a production-hardening item before high-volume deployment.

## REST API surface

Customer endpoints:

- `GET /healthz`
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

Operator endpoints:

- `POST /v1/admin/organizations`
- `POST /v1/admin/capacity/clear/{currency}`

## Financial invariants

For every journal entry and currency:

```text
sum(postings) = 0
```

For every closed netting set and currency:

```text
sum(net_positions) = 0
```

For every market clearing operation:

```text
filled_amount(order) <= remaining_amount(order)
```

For every customer transfer:

```text
amount <= max_single_transfer
amount <= credit_limit + collateral
```

These are execution constraints, not dashboard warnings.

## Deployment configuration

Required environment variables for a non-development deployment:

```text
LZ_ENVIRONMENT=production
LZ_DATABASE_URL=postgresql+psycopg://...
LZ_API_KEY=<strong-operator-secret>
LZ_WEBHOOK_TOLERANCE_SECONDS=300
LZ_PUBLIC_BASE_URL=https://api.example.com
```

Do not use the repository development secrets in production.

The container starts with:

```text
python -m lz.migrate
uvicorn lz.api:app ...
```

## Verification

The GitHub CI pipeline independently runs:

```bash
pip install -e '.[dev]'
python -m compileall -q lz tests
ruff check lz tests
mypy lz
pytest tests
docker build .
```

The integration contract test provisions a tenant, authenticates with the generated tenant key, creates a participant, sets settlement-capacity limits, verifies idempotent transfer behavior, rejects an over-limit transfer, and creates a reconciliation mismatch against PostgreSQL.

## Production boundary

This release is directly integratable for development, sandbox pilots, architecture evaluation, and fintech partner integration testing. It is not yet a regulated production money-movement network.

Before enabling real funds, the system still requires at minimum:

- contracted bank/payment-network or regulated infrastructure partners
- production rail adapters using real provider credentials
- KYB/KYC/AML/sanctions integrations appropriate to the operating model
- legally enforceable collateral and credit arrangements
- a durable webhook/event outbox and worker fleet
- API-key rotation/revocation and production KMS/HSM-backed secret management
- granular RBAC for operator actions
- independent bank/rail reconciliation and settlement-finality ingestion
- rate limiting, WAF controls, audit retention, alerting, and incident runbooks
- penetration testing and dependency/security scanning
- legal and regulatory review for each jurisdiction and product role

The repository deliberately keeps those boundaries explicit instead of simulating regulated connectivity.

## Development

```bash
python -m venv .venv
source .venv/bin/activate
pip install -e '.[dev]'
pytest
ruff check lz tests
mypy lz
```
