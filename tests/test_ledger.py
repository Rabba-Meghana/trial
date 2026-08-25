import pytest

from lz.ledger import JournalEntry, Posting


def test_balanced_entry_is_accepted() -> None:
    entry = JournalEntry.create(
        "j1",
        [Posting("cash:a", "USD", -10_000), Posting("cash:b", "USD", 10_000)],
        "settlement:test",
    )
    assert sum(p.minor for p in entry.postings) == 0


def test_unbalanced_entry_is_rejected() -> None:
    with pytest.raises(ValueError, match="unbalanced"):
        JournalEntry.create(
            "j2",
            [Posting("cash:a", "USD", -10_000), Posting("cash:b", "USD", 9_999)],
            "settlement:test",
        )


def test_cross_currency_imbalance_is_rejected() -> None:
    with pytest.raises(ValueError, match="unbalanced"):
        JournalEntry.create(
            "j3",
            [Posting("cash:a", "USD", -10_000), Posting("cash:b", "EUR", 10_000)],
            "fx:test",
        )
