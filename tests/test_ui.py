from fastapi.testclient import TestClient

from lz.server import app


def test_control_plane_is_served() -> None:
    client = TestClient(app)
    response = client.get("/ui")
    assert response.status_code == 200
    assert "Liquidity Zero" in response.text
    assert "GLOBAL SETTLEMENT CAPACITY NETWORK" in response.text
    assert "Liquidity Zero | Settlement Capacity Network" in response.text


def test_root_redirects_to_control_plane() -> None:
    client = TestClient(app, follow_redirects=False)
    response = client.get("/")
    assert response.status_code in {302, 307}
    assert response.headers["location"] == "/ui"
