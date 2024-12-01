from fastapi.testclient import TestClient
from starlette import status

from app.main import app

client = TestClient(app)


def test_health() -> None:
    r = client.get("api/v1/health")
    assert r.text.strip('"').startswith("OK")
    assert r.status_code == status.HTTP_200_OK
