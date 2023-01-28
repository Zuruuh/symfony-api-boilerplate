DOCKER_COMPOSE = docker compose -f ./docker-compose.dev.yaml
SYMFONY_CLI = symfony
SYMFONY_CONSOLE = $(SYMFONY_CLI) console
PHP = $(SYMFONY_CLI) php
COMPOSER = $(SYMFONY_CLI) composer
PHPSTAN = $(PHP) vendor/bin/phpstan

start:
	$(DOCKER_COMPOSE) up --wait -d
	$(SYMFONY_CLI) serve -d

stop:
	$(DOCKER_COMPOSE) down -v
	$(SYMFONY_CLI) server:stop

lint: symfony-lint phpstan

symfony-lint:
	$(SYMFONY_CONSOLE) lint:container
	$(SYMFONY_CONSOLE) lint:twig templates/
	$(SYMFONY_CONSOLE) lint:yaml config/ ./docker-compose.dev.yaml --parse-tags

phpstan:
	$(PHPSTAN) analyse

.PHONY: start stop lint symfony-lint phpstan