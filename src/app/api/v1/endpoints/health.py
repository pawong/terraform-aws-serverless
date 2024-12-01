import time
import logging

from fastapi import APIRouter

logger = logging.getLogger(__name__)

router = APIRouter()


@router.get("")
def health() -> str:
    """health check endpoint"""
    logger.debug("Health check called...")
    return f"OK - {int(time.time())}"
