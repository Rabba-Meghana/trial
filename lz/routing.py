from __future__ import annotations

import heapq
from dataclasses import dataclass


@dataclass(frozen=True, slots=True)
class LiquidityEdge:
    src: str
    dst: str
    currency: str
    capacity_minor: int
    cost_bps: int
    latency_ms: int
    risk_ppm: int

    def __post_init__(self) -> None:
        if self.capacity_minor <= 0:
            raise ValueError("edge capacity must be positive")
        if min(self.cost_bps, self.latency_ms, self.risk_ppm) < 0:
            raise ValueError("edge metrics cannot be negative")


@dataclass(frozen=True, slots=True)
class Route:
    nodes: tuple[str, ...]
    amount_minor: int
    total_cost_bps: int
    total_latency_ms: int
    aggregate_risk_ppm: int


def cheapest_feasible_route(
    edges: list[LiquidityEdge],
    src: str,
    dst: str,
    currency: str,
    amount_minor: int,
    *,
    max_latency_ms: int | None = None,
    max_risk_ppm: int | None = None,
) -> Route:
    """Find a lowest-cost feasible path without splitting the requested flow.

    This first production kernel intentionally solves an unsplittable path problem. Each edge
    must independently have enough residual capacity. Multi-path min-cost flow is a later layer.
    """
    if amount_minor <= 0:
        raise ValueError("amount must be positive")

    graph: dict[str, list[LiquidityEdge]] = {}
    for edge in edges:
        if edge.currency == currency and edge.capacity_minor >= amount_minor:
            graph.setdefault(edge.src, []).append(edge)

    queue: list[tuple[int, int, int, str, tuple[str, ...]]] = [(0, 0, 0, src, (src,))]
    best: dict[tuple[str, int, int], int] = {}

    while queue:
        cost, latency, risk, node, path = heapq.heappop(queue)
        if node == dst:
            return Route(path, amount_minor, cost, latency, risk)
        state = (node, latency, risk)
        if best.get(state, 10**18) <= cost:
            continue
        best[state] = cost

        for edge in graph.get(node, []):
            if edge.dst in path:
                continue
            next_latency = latency + edge.latency_ms
            next_risk = risk + edge.risk_ppm
            if max_latency_ms is not None and next_latency > max_latency_ms:
                continue
            if max_risk_ppm is not None and next_risk > max_risk_ppm:
                continue
            heapq.heappush(
                queue,
                (
                    cost + edge.cost_bps,
                    next_latency,
                    next_risk,
                    edge.dst,
                    (*path, edge.dst),
                ),
            )

    raise ValueError("no feasible liquidity route")
