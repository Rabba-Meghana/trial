from __future__ import annotations

from dataclasses import dataclass
from datetime import UTC, datetime
from typing import Iterable


@dataclass(frozen=True, slots=True)
class Posting:
    account: str
    currency: str
    minor: int

    def __post_init__(self) -> None:
        if not self.account:
            raise ValueError("account is required")
        if self.minor == 0:
            raise ValueError("zero-value postings are forbidden")


@dataclass(frozen=True, slots=True)
class JournalEntry:
    id: str
    created_at: datetime
    postings: tuple[Posting, ...]
    reference: str

    @classmethod
    def create(cls, entry_id: str, postings: Iterable[Posting], reference: str) -> JournalEntry:
        materialized = tuple(postings)
        validate_balanced(materialized)
        return cls(entry_id, datetime.now(UTC), materialized, reference)


def validate_balanced(postings: Iterable[Posting]) -> None:
    totals: dict[str, int] = {}
    count = 0
    for posting in postings:
        count += 1
        totals[posting.currency] = totals.get(posting.currency, 0) + posting.minor
    if count < 2:
        raise ValueError("a journal entry requires at least two postings")
    broken = {currency: total for currency, total in totals.items() if total != 0}
    if broken:
        raise ValueError(f"unbalanced journal entry: {broken}")
