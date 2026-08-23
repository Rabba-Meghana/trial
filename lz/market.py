from __future__ import annotations

from collections import defaultdict

from .domain import CapacityFill, CapacityOrder, Side


def _windows_overlap(a: CapacityOrder, b: CapacityOrder) -> bool:
    return max(a.window_start, b.window_start) < min(a.window_end, b.window_end)


def clear_capacity_market(orders: list[CapacityOrder]) -> list[CapacityFill]:
    """Price-time matching for settlement capacity.

    Buyers express a maximum price in basis points; sellers express a minimum price.
    Orders only match for the same currency and overlapping settlement windows.
    The execution price is the resting seller's ask, making the rule deterministic.
    """
    seen: set[str] = set()
    for order in orders:
        if order.id in seen:
            raise ValueError(f"duplicate order id: {order.id}")
        seen.add(order.id)

    groups: dict[str, list[CapacityOrder]] = defaultdict(list)
    for order in orders:
        groups[order.currency].append(order)

    fills: list[CapacityFill] = []
    for currency, group in groups.items():
        buys = sorted(
            (o for o in group if o.side == Side.BUY),
            key=lambda o: (-o.price_bps, o.window_start, o.id),
        )
        sells = sorted(
            (o for o in group if o.side == Side.SELL),
            key=lambda o: (o.price_bps, o.window_start, o.id),
        )
        remaining = {o.id: o.amount_minor for o in group}

        for buy in buys:
            if remaining[buy.id] == 0:
                continue
            for sell in sells:
                if remaining[buy.id] == 0:
                    break
                if remaining[sell.id] == 0:
                    continue
                if buy.participant == sell.participant:
                    continue
                if sell.price_bps > buy.price_bps:
                    break
                if not _windows_overlap(buy, sell):
                    continue
                amount = min(remaining[buy.id], remaining[sell.id])
                remaining[buy.id] -= amount
                remaining[sell.id] -= amount
                fills.append(
                    CapacityFill(
                        buy_order_id=buy.id,
                        sell_order_id=sell.id,
                        buyer=buy.participant,
                        seller=sell.participant,
                        currency=currency,
                        amount_minor=amount,
                        price_bps=sell.price_bps,
                    )
                )
    return fills
