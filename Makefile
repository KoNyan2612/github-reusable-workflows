SHELL = /bin/bash
.DEFAULT_GOAL = help

##@ Bootstrap
.PHONY: pre-commit-init repo-init init

pre-commit-init:  ## Install pre-commit
	pip install pre-commit

repo-init:  ## Install git hook scripts
	pre-commit install

init: pre-commit-init repo-init  ## All Init steps at once

##@ Checks
.PHONY: check

check:  ## Run pre-commit against all files
	pre-commit run --all-files

##@ Helpers
.PHONY: help

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-24s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
