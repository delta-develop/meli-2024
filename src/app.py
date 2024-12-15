from flask import Flask, jsonify, Response, request
from utils.response import CustomResponse
from typing import Tuple
from handlers.chain_builder import build_handler_chain
from handlers.csv_handler import CSVHandler
from utils.logger import get_logger

app = Flask(__name__)
logger = get_logger(__name__)


@app.route("/")
def home():
    return CustomResponse.response(
        message="Hello World!",
        status=200,
        data={"content": "my_content", "author": "Leonardo HG"},
    )


@app.route("/upload", methods=["POST"])
def upload() -> Tuple[Response, int]:
    file = request.files["file"]
    content_type = file.content_type

    handler_chain = build_handler_chain()

    logger.info(content_type)

    try:

        def stream_response():
            yield from handler_chain.handle(content_type, file.stream)

        response = list(stream_response())

        return Response(response, content_type="text/plain", status=200)
    except Exception as e:
        return jsonify({"error": str(e)}), 415


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5001)
