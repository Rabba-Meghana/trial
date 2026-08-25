# Security and Production Gates

Liquidity Zero is financial infrastructure. A passing unit-test suite is necessary but not sufficient for production money movement.

## Trust boundaries

1. Participant API clients are untrusted.
2. External bank, payment-rail, custodian, FX, and stablecoin responses are untrusted until independently reconciled.
3. Internal services authenticate every request and operate with least privilege.
4. Financial state changes are append-only events plus explicitly modeled compensating entries; historical journal rows are never edited in place.
5. LLM or probabilistic model output must never directly authorize, commit, or settle a financial transaction.

## Required production controls

Before live funds are enabled:

- replace static API keys with participant-scoped credentials and rotation;
- store secrets in a managed KMS/secret manager;
- use TLS everywhere and mTLS/service identity internally;
- add RBAC/ABAC for participant and operator actions;
- introduce four-eyes approval for sensitive administrative actions;
- use schema migrations with reviewed forward/backward plans;
- add an append-only tamper-evident audit event chain;
- isolate participant data and enforce tenant authorization at every read/write boundary;
- perform KYB/KYC/AML/sanctions controls as required by the legal operating model;
- model credit, collateral, concentration, liquidity, and counterparty limits;
- reconcile ledger and settlement state against independent provider statements;
- define duplicate, timeout, ambiguous-success, reversal, return, and partial-failure semantics for every rail connector;
- establish RPO/RTO objectives, backups, restore tests, incident response, and kill switches;
- conduct dependency/SBOM scanning, SAST, DAST, penetration testing, and external security review;
- obtain legal/regulatory analysis for every jurisdiction and activity before offering real settlement or credit.

## Core invariants

The application must fail closed when any of these are violated:

- per-currency journal postings sum to zero;
- per-currency closed-set net positions sum to zero;
- no order can fill beyond its remaining quantity;
- no participant may match against itself;
- no settlement route may exceed committed capacity;
- idempotency prevents duplicate creation/execution of the same financial intent;
- authorization and participant scope are checked before state access;
- final settlement is not asserted without authoritative settlement evidence.

## Vulnerability reporting

Do not include credentials, personal data, bank account data, or exploitable production details in public issues. Use a private security reporting channel before any public launch.
