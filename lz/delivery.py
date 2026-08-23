from __future__ import annotations

from dataclasses import dataclass

import httpx


@dataclass(frozen=True, slots=True)
class DeliveryResult:
    status_code: int
    attempts: int


def deliver(url: str, body: bytes, headers: dict[str, str], *, attempts: int = 3) -> DeliveryResult:
    if attempts < 1:
        raise ValueError("attempts must be positive")
    last_status = 0
    with httpx.Client(timeout=5.0, follow_redirects=False) as client:
        for attempt in range(1, attempts + 1):
            try:
                response = client.post(url, content=body, headers=headers)
                last_status = response.status_code
                if 200 <= response.status_code < 300:
                    return DeliveryResult(status_code=response.status_code, attempts=attempt)
            except httpx.HTTPError:
                last_status = 0
    return DeliveryResult(status_code=last_status, attempts=attempts)
