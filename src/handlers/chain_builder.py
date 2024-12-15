from .csv_handler import CSVHandler
from .json_handler import JsonHandler


def build_handler_chain():
    json_handler = JsonHandler()
    csv_handler = CSVHandler()
    json_handler.set_next(CSVHandler())
    return json_handler
