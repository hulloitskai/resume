## ----- VARIABLES -----
## Program version.
VERSION = latest
ifneq ($(shell git describe --tags 2> /dev/null),)
	VERSION = $(shell git describe --tags | cut -c 2-)
endif

## Project variables:
DKDIR = ./build


## ----- TARGETS ------
## Generic:
.PHONY: default version setup install build clean run lint test review release \
        help
__ARGS = $(filter-out $@,$(MAKECMDGOALS))

default: run
version: ## Show project version (derived from 'git describe').
	@echo $(VERSION)

setup: ## Set this project up on a new environment.
	@$(MAKE) js-setup -- $(__ARGS)
install: ## Install project dependencies.
	@$(MAKE) js-install -- $(__ARGS)
build: ## Build project.
	@$(MAKE) js-build -- $(__ARGS)
run: ## Run project (development).
	@$(MAKE) js-run -- $(__ARGS)
test: ## Run tests.
	@echo "No testing procedure defined."
lint: ## Lint and check code.
	@$(MAKE) js-lint -- $(__ARGS)
review: ## Lint code and run tests.
	@$(MAKE) js-review -- $(__ARGS)
clean: ## Clean build artifacts.
	@$(MAKE) js-clean && \
	 echo "Cleaning dist/..." && rm -rf dist/ && echo done
release: ## Release / deploy this project.
	@echo "Releasing using 'yarn build:prefix'..." && \
	 yarn build:prefix $(__ARGS) && \
	 echo done

## Show usage for the targets in this Makefile.
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	 awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'


## CI:
.PHONY: ci-install ci-test ci-build ci-deploy

BRANCH        ?= $(shell git rev-parse --abbrev-ref HEAD)
RELEASEBRANCH ?= master

ci-install:
	@$(MAKE) DKENV=build dk-pull && \
	 $(MAKE) DKENV=test  dk-pull
ci-test:
	@$(MAKE) dk-test -- $(__ARGS)
ci-build:
	@$(MAKE) DKENV=build dk-build
ci-deploy: SHELL := bash
ci-deploy:
	@if [ "$(BRANCH)" == "$(RELEASEBRANCH)" ]; then \
	   VERSIONS="$(VERSION) latest"; \
	 else \
	   VERSIONS="$(BRANCH)-$$(git describe --always)"; \
	 fi && \
	 for VERSION in $$VERSIONS; do \
	   $(MAKE) DKENV=build dk-tag $$VERSION && \
	   $(MAKE) DKENV=build VERSION="$$VERSION" dk-push; \
	 done && \
	 $(MAKE) DKENV=test dk-push


## Javascript:
.PHONY: js-setup js-install js-build js-run js-test js-lint js-review js-clean \
        js-release

js-setup:
	@$(MAKE) js-install -- $(__ARGS)
js-install:
	@echo "Installing package dependencies..." && yarn install $(__ARGS)
js-build:
	@echo "Building static files for production..." && yarn build $(__ARGS)
js-run:
	@echo "Starting development server..." && yarn dev $(__ARGS)
js-lint:
	@echo "Linting code with 'yarn lint'..." && yarn lint $(__ARGS)
js-review:
	@$(MAKE) js-lint -- $(__ARGS)
js-clean:
	@echo "Cleaning 'node_modules'..." && rm -rf node_modules && echo done


## Docker:
.PHONY: dk-pull dk-push dk-build dk-build-push dk-clean dk-tag dk-up \
        dk-build-up dk-down dk-logs dk-test

DKDIR ?= .

__DKFILE = $(DKDIR)/docker-compose.yml
ifneq ($(DKENV),)
	__DKFILE = $(DKDIR)/docker-compose.$(DKENV).yml
endif

__DK        = docker
__DKCMP     = docker-compose -f "$(__DKFILE)"
__DKCMP_VER = VERSION="$(VERSION)" $(__DKCMP)
__DKCMP_LST = VERSION=latest $(__DKCMP)

dk-pull: ## Pull latest Docker images from registry.
	@echo "Pulling latest images from registry..." && \
	 $(__DKCMP_LST) pull $(__ARGS)
dk-push: ## Push new Docker images to registry.
	@echo "Pushing images to registry (:$(VERSION))..." && \
	 $(__DKCMP_VER) push $(__ARGS) && \
	 echo done

dk-build: ## Build and tag Docker images.
	@echo "Building images..." && \
	 $(__DKCMP_VER) build --parallel --compress $(__ARGS) && \
	 echo done
dk-clean: ## Clean up unused Docker data.
	@echo "Cleaning unused data..." && $(__DK) system prune $(__ARGS)
dk-tag: ## Re-tag Docker images with other names.
	@TAG=latest && if [ -n "$(__ARGS)" ]; then TAG="$(__ARGS)"; fi && \
	 echo "Tagging versioned images with ':$$TAG'..." && \
	 IMAGES="$$($(__DKCMP_VER) config | grep image | awk '{print $$2}')" && \
	 for IMG in $$IMAGES; do \
	   if [ -z "$$($(__DK) images -q "$$IMG" 2> /dev/null)" ]; then \
	     continue; \
	   fi && \
	   echo "$$IMG" | sed -e "s/:.*$$/:$$TAG/" | xargs $(__DK) tag "$$IMG"; \
	 done && \
	 echo done
dk-build-push: dk-build dk-push ## Build and push new Docker images.

__DK_UP = $(__DKCMP_VER) up
dk-up: ## Start up containerized services.
	@echo "Bringing up services..." && $(__DK_UP) $(__ARGS) && echo done
dk-down: ## Shut down containerized services.
	@echo "Bringing down services..." && \
	 $(__DKCMP_VER) down $(__ARGS) && \
	 echo done
dk-build-up: ## Build new images, then start them.
	@echo "Building and bringing up services..." && \
	 $(__DK_UP) --build $(__ARGS) && \
	 echo done

dk-logs: ## Show logs for containerized services.
	@$(__DKCMP_VER) logs -f $(__ARGS)
dk-test: ## Test using 'docker-compose.test.yml'.
	$(eval __DKFILE = $(DKDIR)/docker-compose.test.yml)
	@if [ -s "$(__DKFILE)" ]; then \
	   echo "Running containerized service tests..." && \
	   for svc in $$($(__DKCMP_LST) config --services); do \
	     if ! $(__DK_UP) --abort-on-container-exit $(__ARGS) "$$svc"; \
	       then exit -1; \
	     fi \
	   done; \
	 fi && \
	 echo done


## HACKS:
## These targets are hacks that allow for Make targets to receive
## pseudo-arguments.
.PHONY: __FORCE
__FORCE:
%: __FORCE
	@:
