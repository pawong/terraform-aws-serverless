from fastapi.testclient import TestClient
from starlette import status

from app.api.v1.endpoints.eball import answers
from app.main import app

client = TestClient(app)


def test_get_answer_only() -> None:
    r = client.get("api/v1/eball")
    assert r.text.strip('"') in answers
    assert r.status_code == status.HTTP_200_OK


def test_get_answer() -> None:
    r = client.post("api/v1/eball", content='{"question":"Will I die today?"}')
    assert r.json()["question"] == "Will I die today?"
    assert r.json()["answer"] in answers
    assert r.status_code == status.HTTP_200_OK
