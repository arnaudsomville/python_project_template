"""Testing src/api/api.py functions."""

from api.api import FizzbuzzBody, app
from fastapi.testclient import TestClient
from processings.fizzbuzz import fizzbuzz

client = TestClient(app)


def test_health_endpoint() -> None:
    """Test api endpoint health."""
    response = client.get('/health')
    assert response.status_code == 200  # noqa: PLR2004
    assert response.json() == 'OK'


def test_fizzbuzz_endpoint() -> None:
    """Test api endpoint fizzbuzz."""
    response = client.post('/fizzbuzz', content=FizzbuzzBody(value=2).model_dump_json())
    assert response.status_code == 200  # noqa: PLR2004
    assert response.json() == fizzbuzz(2)
