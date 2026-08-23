from __future__ import annotations

from collections import defaultdict
from dataclasses import dataclass
from typing import Iterable

from .domain import Obligation, ParticipantId


@dataclass(frozen=True, slots=True)
class NetPosition:
    participant: ParticipantId
    currency: str
    minor: int

    @property
    def direction(self) -> str:
        if self.minor > 0:
            return "receive"
        if self.minor < 0:
            return "pay"
        return "flat"


def multilateral_net(obligations: Iterable[Obligation]) -> list[NetPosition]:
    """Net obligations by participant/currency.

    Positive positions receive funds; negative positions owe funds. For every currency,
    the returned positions must sum to zero. Any violation indicates a programming or
    data-integrity error and aborts the calculation.
    """
    balances: dict[tuple[ParticipantId, str], int] = defaultdict(int)
    seen_ids: set[str] = set()

    for obligation in obligations:
        if obligation.id in seen_ids:
            raise ValueError(f"duplicate obligation id: {obligation.id}")
        seen_ids.add(obligation.id)
        key_payer = (obligation.payer, obligation.amount.currency)
        key_payee = (obligation.payee, obligation.amount.currency)
        balances[key_payer] -= obligation.amount.minor
        balances[key_payee] += obligation.amount.minor

    by_currency: dict[str, int] = defaultdict(int)
    for (_, currency), amount in balances.items():
        by_currency[currency] += amount
    broken = {c: v for c, v in by_currency.items() if v != 0}
    if broken:
        raise RuntimeError(f"netting conservation violation: {broken}")

    return sorted(
        (
            NetPosition(participant=p, currency=c, minor=minor)
            for (p, c), minor in balances.items()
            if minor != 0
        ),
        key=lambda x: (x.currency, str(x.participant)),
    )
