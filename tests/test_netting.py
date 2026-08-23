from datetime import UTC, datetime

import pytest
from hypothesis import given, strategies as st

from lz.domain import Money, Obligation, ParticipantId
from lz.netting import multilateral_net


def test_three_party_cycle_nets_to_zero() -> None:
    now = datetime.now(UTC)
    obligations = [
        Obligation("1", ParticipantId("A"), ParticipantId("B"), Money("USD", 100), now),
        Obligation("2", ParticipantId("B"), ParticipantId("C"), Money("USD", 100), now),
        Obligation("3", ParticipantId("C"), ParticipantId("A"), Money("USD", 100), now),
    ]
    assert multilateral_net(obligations) == []


def test_duplicate_obligation_rejected() -> None:
    now = datetime.now(UTC)
    item = Obligation("x", ParticipantId("A"), ParticipantId("B"), Money("USD", 100), now)
    with pytest.raises(ValueError, match="duplicate obligation"):
        multilateral_net([item, item])


@given(st.lists(st.integers(min_value=1, max_value=10_000), min_size=1, max_size=50))
def test_netting_always_conserves_value(amounts: list[int]) -> None:
    now = datetime.now(UTC)
    obligations = [
        Obligation(
            str(i),
            ParticipantId(f"P{i}"),
            ParticipantId(f"P{i + 1}"),
            Money("USD", amount),
            now,
        )
        for i, amount in enumerate(amounts)
    ]
    positions = multilateral_net(obligations)
    assert sum(position.minor for position in positions) == 0
