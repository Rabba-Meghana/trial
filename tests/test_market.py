from datetime import UTC, datetime, timedelta

from lz.domain import CapacityOrder, ParticipantId, Side
from lz.market import clear_capacity_market


def order(
    oid: str,
    participant: str,
    side: Side,
    amount: int,
    price: int,
    start: datetime,
    end: datetime,
) -> CapacityOrder:
    return CapacityOrder(
        id=oid,
        participant=ParticipantId(participant),
        side=side,
        currency="USD",
        amount_minor=amount,
        price_bps=price,
        window_start=start,
        window_end=end,
    )


def test_price_time_matching_and_partial_fill() -> None:
    start = datetime.now(UTC)
    end = start + timedelta(hours=1)
    fills = clear_capacity_market(
        [
            order("b1", "buyer", Side.BUY, 1_000, 8, start, end),
            order("s1", "seller1", Side.SELL, 400, 4, start, end),
            order("s2", "seller2", Side.SELL, 900, 6, start, end),
        ]
    )
    assert [(f.seller, f.amount_minor, f.price_bps) for f in fills] == [
        (ParticipantId("seller1"), 400, 4),
        (ParticipantId("seller2"), 600, 6),
    ]


def test_non_overlapping_windows_do_not_match() -> None:
    t0 = datetime.now(UTC)
    fills = clear_capacity_market(
        [
            order("b", "A", Side.BUY, 100, 10, t0, t0 + timedelta(minutes=30)),
            order(
                "s",
                "B",
                Side.SELL,
                100,
                1,
                t0 + timedelta(hours=1),
                t0 + timedelta(hours=2),
            ),
        ]
    )
    assert fills == []
