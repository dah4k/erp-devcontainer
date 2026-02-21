# Copyright 2026 dah4k
# SPDX-License-Identifier: EPL-2.0

DOCKER      ?= docker
COMPOSE     ?= docker compose
_ANSI_NORM  := \033[0m
_ANSI_CYAN  := \033[36m

.PHONY: help usage
help usage:
	@grep -hE '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?##"}; {printf "$(_ANSI_CYAN)%-20s$(_ANSI_NORM) %s\n", $$1, $$2}'

.PHONY: all
all: $(TAGS) ## Start all containers
	$(COMPOSE) up -d

.PHONY: debug
debug: ## Debug most recent container
	$(DOCKER) exec --interactive --tty --user root `$(DOCKER) ps --latest --quiet` /bin/bash

.PHONY: clean
clean: ## Stop all containers
	$(COMPOSE) down --remove-orphans

.PHONY: distclean
distclean: ## Stop all containers and remove volumes
	$(COMPOSE) down --remove-orphans --volumes
