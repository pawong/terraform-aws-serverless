from fastapi import APIRouter

from .endpoints import health, eball

router = APIRouter()
router.include_router(health.router, prefix="/health", tags=["Health"])
router.include_router(eball.router, prefix="/eball", tags=["EBall"])
