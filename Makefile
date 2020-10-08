ENV_FILE ?= ./conf/camino/$(shell cat .env)
include $(ENV_FILE)
DOCKER_COMPOSE :=  docker-compose -f $(COMPOSE_FILE) --env-file=$(ENV_FILE)
DB_DUMP_PATH := /var/data/dbdump

.PHONY: deploy-core
deploy-core:
	$(DOCKER_COMPOSE) pull core
	$(DOCKER_COMPOSE) stop core
	$(DOCKER_COMPOSE) up -d
	docker exec frontera_django python3 manage.py migrate
	docker exec frontera_django python3 manage.py collectstatic --noinput
	$(DOCKER_COMPOSE) restart nginx

.PHONY: deploy-cms
deploy-cms:
	$(DOCKER_COMPOSE) pull cms
	$(DOCKER_COMPOSE) stop cms
	$(DOCKER_COMPOSE) up -d
	docker exec frontera_cms python3 manage.py migrate
	docker exec frontera_cms python3 manage.py collectstatic --noinput
	$(DOCKER_COMPOSE) restart nginx

.PHONY: deploy-docs
deploy-docs:
	$(DOCKER_COMPOSE) pull docs
	$(DOCKER_COMPOSE) run docs
	$(DOCKER_COMPOSE) restart nginx

.PHONY: deploy-all
deploy-all:
	$(DOCKER_COMPOSE) pull
	$(DOCKER_COMPOSE) stop
	$(DOCKER_COMPOSE) up -d
	docker exec frontera_django python3 manage.py migrate
	docker exec frontera_django python3 manage.py collectstatic --noinput
	docker exec frontera_cms python3 manage.py migrate
	docker exec frontera_cms python3 manage.py collectstatic --noinput
	$(DOCKER_COMPOSE) restart nginx

.PHONY: stop
stop:
	$(DOCKER_COMPOSE) stop $(service)

.PHONY: start
start:
	$(DOCKER_COMPOSE) start $(service)

.PHONY: down
down:
	$(DOCKER_COMPOSE) down $(service)

.PHONY: up
up:
	$(DOCKER_COMPOSE) up -d $(service)

.PHONY: pull
pull:
	$(DOCKER_COMPOSE) pull $(service)

.PHONY: restart
restart:
	$(DOCKER_COMPOSE) stop $(service)
	$(DOCKER_COMPOSE) up -d $(service)
	$(DOCKER_COMPOSE) restart nginx

.PHONY: deploy
deploy:
	$(DOCKER_COMPOSE) pull $(service)
	$(DOCKER_COMPOSE) stop $(service)
	$(DOCKER_COMPOSE) up -d $(service)
	$(DOCKER_COMPOSE) restart nginx

.PHONY: migrate
migrate:
	$(DOCKER_COMPOSE) exec $(service) python manage.py migrate

.PHONY: collectstatic
collectstatic:
	$(DOCKER_COMPOSE) exec $(service) python manage.py collectstatic --noinput

.PHONY: dbdump
dbdump:
	$(eval FILE_NAME := $(service)_$(shell date --iso=seconds).sql)
	$(DOCKER_COMPOSE) run --no-deps --rm $(service) pg_dump --dbname=$(DB_NAME) --host=$(DB_HOST) --username=$(DB_USER) --clean --no-owner > $(DB_DUMP_PATH)/$(FILE_NAME)
