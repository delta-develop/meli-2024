# Variables del proyecto
PROJECT_NAME = meli
DOCKER_COMPOSE_FILE = docker-compose.yml
DOCKER_IMAGE_NAME = Dockerfile

# Comandos básicos
.PHONY: build up down restart clean logs shell test

# Construir la imagen del proyecto
build:
	@echo "Construyendo la imagen del proyecto..."
	docker-compose -f $(DOCKER_COMPOSE_FILE) build --no-cache

# Levantar los servicios
up:
	@echo "Levantando los servicios..."
	docker-compose -f $(DOCKER_COMPOSE_FILE) up -d

up_logs:
	@echo "Levantando los servicios..."
	docker-compose -f $(DOCKER_COMPOSE_FILE) up

# Detener los servicios
down:
	@echo "Deteniendo los servicios..."
	docker-compose -f $(DOCKER_COMPOSE_FILE) down

# Reiniciar los servicios
restart: down up

# Limpiar contenedores y volúmenes
clean:
	@echo "Limpiando contenedores y volúmenes..."
	docker-compose -f $(DOCKER_COMPOSE_FILE) down -v

# Ver logs de la aplicación
logs:
	@echo "Mostrando logs del servicio principal..."
	docker-compose -f $(DOCKER_COMPOSE_FILE) logs -f app

# Acceder al contenedor principal
shell:
	@echo "Abriendo shell en el contenedor principal..."
	docker exec -it $$(docker ps -qf "name=app") bash

# Ejecutar pruebas
test:
	@echo "Ejecutando pruebas dentro del contenedor..."
	docker exec -it $$(docker ps -qf "name=app") poetry run pytest
