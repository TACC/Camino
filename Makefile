.PHONY: get-latest
get-latest:
	git pull

.PHONY: deploy-core
deploy-core:
	docker-compose pull core
	docker-compose stop core
	docker-compose up -d
	docker exec frontera_django python3 manage.py collectstatic --noinput

.PHONY: deploy-cms
deploy-cms:
	docker-compose pull cms
	docker-compose stop cms
	docker-compose up -d
	docker exec frontera_cms python3 manage.py collectstatic --noinput

.PHONY: deploy-all
deploy-all:
	docker-compose pull
	docker-compose stop
	docker-compose up -d
	docker exec frontera_django python3 manage.py collectstatic --noinput
	docker exec frontera_cms python3 manage.py collectstatic --noinput
