import pytest

from lz.routing import LiquidityEdge, cheapest_feasible_route


def test_selects_lowest_cost_feasible_route() -> None:
    edges = [
        LiquidityEdge("A", "B", "USD", 1_000, 2, 10, 10),
        LiquidityEdge("B", "D", "USD", 1_000, 2, 10, 10),
        LiquidityEdge("A", "C", "USD", 1_000, 1, 100, 10),
        LiquidityEdge("C", "D", "USD", 1_000, 1, 100, 10),
    ]
    route = cheapest_feasible_route(edges, "A", "D", "USD", 500, max_latency_ms=50)
    assert route.nodes == ("A", "B", "D")
    assert route.total_cost_bps == 4


def test_capacity_constraint_is_enforced() -> None:
    edges = [LiquidityEdge("A", "B", "USD", 99, 1, 1, 1)]
    with pytest.raises(ValueError, match="no feasible"):
        cheapest_feasible_route(edges, "A", "B", "USD", 100)
