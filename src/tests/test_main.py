from fastapi.testclient import TestClient
from starlette import status

from app.main import app

client = TestClient(app)


def test_root() -> None:
    r = client.get("/")
    assert r.json() == {"Hello": "World"}
    assert r.status_code == status.HTTP_200_OK
