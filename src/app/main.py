import logging

from fastapi import FastAPI
from mangum import Mangum

from app.api.v1.api import router as api_router

logger = logging.getLogger("mangum")
logger.setLevel(logging.DEBUG)

app = FastAPI()


@app.get("/")
def read_root() -> dict[str, str]:
    return {"Hello": "World"}


app.include_router(api_router, prefix="/api/v1")

logger.info("Start Mangum...")
handler = Mangum(app)
