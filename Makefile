
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


.PHONY: deploy-dev-core
deploy-dev-core:
	docker-compose -f docker-compose-dev.yml pull core
	docker-compose -f docker-compose-dev.yml stop core
	docker-compose -f docker-compose-dev.yml up -d
	docker exec frontera_django python3 manage.py collectstatic --noinput

.PHONY: deploy-dev-cms
deploy-dev-cms:
	docker-compose -f docker-compose-dev.yml pull cms
	docker-compose -f docker-compose-dev.yml stop cms
	docker-compose -f docker-compose-dev.yml up -d
	docker exec frontera_cms python3 manage.py collectstatic --noinput

.PHONY: deploy-dev-all
deploy-dev-all:
	docker-compose -f docker-compose-dev.yml pull
	docker-compose -f docker-compose-dev.yml stop
	docker-compose -f docker-compose-dev.yml up -d
	docker exec frontera_django python3 manage.py collectstatic --noinput
	docker exec frontera_cms python3 manage.py collectstatic --noinput
