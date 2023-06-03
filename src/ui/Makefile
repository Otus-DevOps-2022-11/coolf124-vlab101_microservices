THIS_FILE := $(lastword $(MAKEFILE_LIST))
default: help

.PHONY: help build up start down destroy stop restart logs logs-api ps
help: #Show help
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done
build: #docker-compose build
	docker-compose -f docker-compose.yml build $(c)
up: #docker-compose up
	docker-compose -f docker-compose.yml up -d $(c)
start: #docker-compose start
	docker-compose -f docker-compose.yml start $(c)
down: #docker-compose down
	docker-compose -f docker-compose.yml down $(c)
destroy:#docker-compose destroy
	docker-compose -f docker-compose.yml down -v $(c)
stop:#docker-compose stop
	docker-compose -f docker-compose.yml stop $(c)
restart:#docker-compose restart
	docker-compose -f docker-compose.yml stop $(c)
	docker-compose -f docker-compose.yml up -d $(c)
logs:#docker-compose logs
	docker-compose -f docker-compose.yml logs --tail=100 -f $(c)
logs-api:#docker-compose logs-api
	docker-compose -f docker-compose.yml logs --tail=100 -f api
ps:#docker-compose ps
	docker-compose -f docker-compose.yml ps
