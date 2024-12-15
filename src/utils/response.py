from flask import jsonify, Response
from typing import Dict, Any, Tuple


class CustomResponse:
    @staticmethod
    def response(
        message: str, status: int, **kwargs: Dict[str, Any]
    ) -> Tuple[Response, int]:
        return jsonify({"message": message, **kwargs}), status
