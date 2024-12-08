FROM python:3.12-slim

RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="/root/.local/bin:$PATH"

WORKDIR /app

COPY pyproject.toml poetry.lock ./

RUN poetry install --no-root

RUN echo "Hola mundo"

COPY . .

EXPOSE 5001

CMD ["poetry", "run", "flask", "--app=src/app.py", "run", "--host=0.0.0.0", "--port=5001", "--debug"]
