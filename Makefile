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

run:
	make build
	make up

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

clean-docker:
	@echo "Limpiando contenedores, imágenes, volúmenes y redes..."
	docker stop $(docker ps -aq) || true
	docker rm $(docker ps -aq) || true
	docker rmi $(docker images -q) || true
	docker volume rm $(docker volume ls -q) || true
	docker network rm $(docker network ls -q) || true
	docker system prune -f --volumes

type-check:
	@echo "Revisando tipado"
	poetry run mypy src/ tests/

format:
	@echo "Formateando código con Black..."
	poetry run black src/ tests/