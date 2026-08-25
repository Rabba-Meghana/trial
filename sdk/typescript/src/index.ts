import { createHmac, timingSafeEqual } from "node:crypto";

export type Json = null | boolean | number | string | Json[] | { [key: string]: Json };

export interface ClientOptions {
  apiKey: string;
  organizationId: string;
  baseUrl?: string;
}

export interface TransferInput {
  participant_id: string;
  amount_minor: number;
  currency: string;
  source_account: string;
  destination_account: string;
  idempotency_key: string;
}

export class LiquidityZeroClient {
  private readonly apiKey: string;
  private readonly organizationId: string;
  private readonly baseUrl: string;

  constructor(options: ClientOptions) {
    this.apiKey = options.apiKey;
    this.organizationId = options.organizationId;
    this.baseUrl = (options.baseUrl ?? "http://localhost:8080").replace(/\/$/, "");
  }

  private async request<T>(method: string, path: string, body?: Json): Promise<T> {
    const response = await fetch(`${this.baseUrl}${path}`, {
      method,
      headers: {
        "content-type": "application/json",
        "x-api-key": this.apiKey,
        "x-lz-organization": this.organizationId,
      },
      body: body === undefined ? undefined : JSON.stringify(body),
    });
    if (!response.ok) {
      const text = await response.text();
      throw new Error(`Liquidity Zero ${response.status}: ${text}`);
    }
    if (response.status === 204) return undefined as T;
    return (await response.json()) as T;
  }

  createParticipant(input: { external_id: string; legal_name: string }) {
    return this.request<Record<string, Json>>("POST", "/v1/participants", input);
  }

  setRiskLimit(
    participantId: string,
    input: {
      currency: string;
      credit_limit_minor: number;
      collateral_minor: number;
      max_single_transfer_minor: number;
    },
  ) {
    return this.request<Record<string, Json>>(
      "PUT",
      `/v1/participants/${participantId}/risk-limit`,
      input,
    );
  }

  createTransfer(input: TransferInput) {
    return this.request<Record<string, Json>>("POST", "/v1/transfers", input as unknown as Json);
  }

  getTransfer(transferId: string) {
    return this.request<Record<string, Json>>("GET", `/v1/transfers/${transferId}`);
  }

  createCapacityOrder(input: {
    participant: string;
    side: "buy" | "sell";
    currency: string;
    amount_minor: number;
    price_bps: number;
    window_start: string;
    window_end: string;
    idempotency_key: string;
  }) {
    return this.request<Record<string, Json>>(
      "POST",
      "/v1/capacity/orders",
      input as unknown as Json,
    );
  }

  reconcile(input: {
    external_reference: string;
    currency: string;
    expected_minor: number;
    observed_minor: number;
  }) {
    return this.request<Record<string, Json>>(
      "POST",
      "/v1/reconciliation",
      input as unknown as Json,
    );
  }

  rotateApiKey() {
    return this.request<{ api_key: string; key_id: string }>("POST", "/v1/api-keys/rotate");
  }

  createWebhookEndpoint(input: { url: string; secret: string }) {
    return this.request<Record<string, Json>>(
      "POST",
      "/v1/webhook-endpoints",
      input,
    );
  }
}

export function verifyWebhook(input: {
  secret: string;
  timestamp: string | number;
  body: string | Uint8Array;
  signature: string;
  toleranceSeconds?: number;
  nowSeconds?: number;
}): boolean {
  const timestamp = Number(input.timestamp);
  if (!Number.isFinite(timestamp)) return false;
  const now = input.nowSeconds ?? Math.floor(Date.now() / 1000);
  if (Math.abs(now - timestamp) > (input.toleranceSeconds ?? 300)) return false;

  const payload = typeof input.body === "string" ? input.body : Buffer.from(input.body).toString("utf8");
  const expected = `v1=${createHmac("sha256", input.secret)
    .update(`${timestamp}.${payload}`)
    .digest("hex")}`;
  const actualBuffer = Buffer.from(input.signature);
  const expectedBuffer = Buffer.from(expected);
  if (actualBuffer.length !== expectedBuffer.length) return false;
  return timingSafeEqual(actualBuffer, expectedBuffer);
}
