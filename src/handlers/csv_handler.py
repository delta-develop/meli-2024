import csv
from typing import Generator, Any
from .base_handler import BaseHandler
from utils.logger import get_logger
import io

logger = get_logger(__name__)


class CSVHandler(BaseHandler):
    def handle(self, content_type: str, stream: Any) -> Generator[str, None, None]:

        if content_type == "text/csv":
            logger.info("Reading CSV file")
            decoded_stream = io.TextIOWrapper(stream, encoding="utf-8")
            file_content = csv.reader(decoded_stream)
            result = {}
            for row in file_content:
                print(row)
        else:
            yield from super().handle(content_type, stream)
