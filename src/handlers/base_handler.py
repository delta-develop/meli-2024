from __future__ import annotations
from typing import Optional, Generator, Any
from abc import ABC, abstractmethod


class BaseHandler(ABC):

    _next_handler: Optional[BaseHandler] = None

    def set_next(self, next_handler: BaseHandler):
        self._next_handler = next_handler
        return next_handler

    @abstractmethod
    def handle(self, content_type: str, stream: Any) -> Generator[str, None, None]:
        if self._next_handler:
            yield from self._next_handler.handle(content_type, stream)
        else:
            raise ValueError(f"Unsupported file type: {content_type}")
