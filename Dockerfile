FROM python:3.11.4-slim

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Establecer el directorio de trabajo
WORKDIR /app

# Crear el entorno virtual
RUN python3 -m venv /venv

# Activar el entorno virtual e instalar las dependencias
COPY requirements.txt .
RUN /venv/bin/pip install --upgrade pip \
    && /venv/bin/pip install -r requirements.txt

# Copiar el código del proyecto
COPY . .

# Exponer los puertos necesarios
EXPOSE 5001 5680

# Configurar el comando de inicio
CMD ["/venv/bin/python", "-m", "flask", "--app=src/app.py", "run", "--host=0.0.0.0", "--port=5001", "--debug"]
