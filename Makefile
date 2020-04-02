COMPOSE_FILE ?= $(shell cat ./compose_file)
DOCKER_COMPOSE :=  docker-compose -f $(COMPOSE_FILE)

.PHONY: deploy-core
deploy-core:
	$(DOCKER_COMPOSE) pull core
	$(DOCKER_COMPOSE) stop core
	$(DOCKER_COMPOSE) up -d
	docker exec frontera_django python3 manage.py collectstatic --noinput
	$(DOCKER_COMPOSE) restart nginx

.PHONY: deploy-cms
deploy-cms:
	$(DOCKER_COMPOSE) pull cms
	$(DOCKER_COMPOSE) stop cms
	$(DOCKER_COMPOSE) up -d
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
	docker exec frontera_django python3 manage.py collectstatic --noinput
	docker exec frontera_cms python3 manage.py collectstatic --noinput
	$(DOCKER_COMPOSE) restart nginx
