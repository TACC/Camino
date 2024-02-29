#!make
ENV_FILE ?= ./.env
include $(ENV_FILE)

# CAMINO_HOME defaults to the path to this Makefile
ifndef CAMINO_HOME
override CAMINO_HOME := $(dir $(lastword $(abspath $(MAKEFILE_LIST))))
endif

DOCKER_COMPOSE :=  docker compose -f ${CAMINO_HOME}/conf/camino/${COMPOSE_FILE} --env-file=$(ENV_FILE)

.PHONY: deploy-docs
deploy-docs:
	$(DOCKER_COMPOSE) pull docs
	$(DOCKER_COMPOSE) run docs
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
	$(DOCKER_COMPOSE) up --force-recreate -d $(service)

.PHONY: deploy
deploy:
	$(DOCKER_COMPOSE) pull $(service)
	$(DOCKER_COMPOSE) stop $(service)
	$(DOCKER_COMPOSE) up -d $(service)
	$(DOCKER_COMPOSE) restart nginx

.PHONY: deploy-all
deploy-all-service:
	$(DOCKER_COMPOSE) pull
	$(DOCKER_COMPOSE) stop
	$(DOCKER_COMPOSE) up -d
	$(DOCKER_COMPOSE) restart nginx
	ifdef POST_DEPLOY_SCRIPT
	chmod +x ${CAMINO_HOME}/conf/camino/${POST_DEPLOY_SCRIPT} && ${CAMINO_HOME}/conf/camino/${POST_DEPLOY_SCRIPT}
	endif

.PHONY: migrate
migrate:
	$(DOCKER_COMPOSE) exec $(service) python3 manage.py migrate

.PHONY: collectstatic
collectstatic:
	$(DOCKER_COMPOSE) exec $(service) python3 manage.py collectstatic --noinput
