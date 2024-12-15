import json
from typing import Generator, Any
from .base_handler import BaseHandler
from utils.logger import get_logger

logger = get_logger(__name__)


class JsonHandler(BaseHandler):
    def handle(self, content_type: str, stream: Any):
        logger.info(f"content-type: {content_type}")
        if content_type == "application/json":
            for line in stream:
                try:
                    data = json.loads(line)
                    yield f"Processed json line: {data}"
                except json.decoder.JSONDecodeError:
                    yield f"Failed to decode json line: {line}"
        else:
            yield from super().handle(content_type, stream)
