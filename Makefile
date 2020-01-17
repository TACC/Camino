.PHONY: get-latest
get-latest:
	git pull

.PHONY: deploy-core
deploy-core:
	docker-compose pull core
	docker-compose stop core
	docker-compose up -d

.PHONY: deploy-cms
deploy-cms:
	docker-compose pull cms
	docker-compose stop cms
	docker-compose up -d

.PHONY: deploy-all
deploy-cms:
	docker-compose pull
	docker-compose stop
	docker-compose up -d
