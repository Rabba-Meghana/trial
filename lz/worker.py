from __future__ import annotations

import time

from .outbox import deliver_pending


def run_forever(poll_seconds: float = 1.0) -> None:
    while True:
        delivered = deliver_pending()
        if delivered == 0:
            time.sleep(poll_seconds)


if __name__ == "__main__":
    run_forever()
