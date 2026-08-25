from __future__ import annotations

import time

from .outbox import deliver_pending
from .security import cleanup_rate_limit_buckets


def run_forever(poll_seconds: float = 1.0) -> None:
    last_cleanup = 0.0
    while True:
        delivered = deliver_pending()
        now = time.monotonic()
        if now - last_cleanup >= 60.0:
            cleanup_rate_limit_buckets()
            last_cleanup = now
        if delivered == 0:
            time.sleep(poll_seconds)


if __name__ == "__main__":
    run_forever()
