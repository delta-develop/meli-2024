import logging


def get_logger(name: str) -> logging.Logger:
    """
    Configura y devuelve un logger.

    :param name: Nombre del logger (normalmente el módulo que lo llama).
    :return: Objeto de logger configurado.
    """
    logger = logging.getLogger(name)
    logger.setLevel(
        logging.DEBUG
    )  # Nivel de log global (DEBUG, INFO, WARNING, ERROR, CRITICAL)

    # Configurar el formateador
    formatter = logging.Formatter(
        fmt="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S",
    )

    # Configurar el handler de consola
    console_handler = logging.StreamHandler()
    console_handler.setLevel(logging.DEBUG)  # Nivel del handler
    console_handler.setFormatter(formatter)

    # Asegurarse de no añadir múltiples handlers al logger
    if not logger.handlers:
        logger.addHandler(console_handler)

    return logger
