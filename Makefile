## ----- VARIABLES -----
## Program version.
VERSION = latest
ifneq ($(shell git describe --tags 2> /dev/null),)
	VERSION = $(shell git describe --tags | cut -c 2-)
endif



## ----- TARGETS ------
## Generic:
.PHONY: default version setup install build run test lint review clean release \
        help

default: run
version: ## Show project version (derived from 'git describe').
	@echo $(VERSION)

setup: js-setup ## Set up this project on a new device.
install: js-install ## Install project dependencies.
build: js-build ## Build project.
run: js-run ## Run project (development).
test: ## Run tests.
	@echo "No testing procedure defined."
lint: js-lint ## Lint and check code.
review: js-review ## Lint code and run tests.
clean: js-clean ## Clean build artifacts.
	@echo "Cleaning dist/..." && rm -rf dist/ && echo done
release: ## Release / deploy this project.
	@echo "Releasing using 'yarn build:prefix'..." && \
	 yarn build:prefix && \
	 echo done

## Show usage for the targets in this Makefile.
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	   awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'


## CI:
.PHONY: ci-install ci-test ci-deploy
__KB = kubectl

ci-install:
	@$(MAKE) dk-pull DKENV=test
ci-test: dk-test
	@$(MAKE) dk-up DKENV=ci DKARGS="--no-start" && \
	 $(MAKE) dk-tags DKENV=ci
ci-deploy:
	@$(MAKE) dk-push DKENV=ci && \
	 for deploy in $(DEPLOYS); do \
	   $(__KB) patch deployment "$$deploy" \
	     -p "{\"spec\":{\"template\":{\"metadata\":{\"annotations\":{\"date\":\"$$(date +'%s')\"}}}}}"; \
	 done


## Javascript:
.PHONY: js-setup js-install js-build js-run js-test js-lint js-review js-clean \
        js-release

js-setup: js-install
js-install:
	@echo "Installing package dependencies..." && yarn install
js-build:
	@echo "Building static files for production..." && yarn build
js-run:
	@echo "Starting development server..." && yarn dev
js-lint:
	@echo "Linting code with 'yarn lint'..." && yarn lint
js-review: js-lint
js-clean:
	@echo "Cleaning 'node_modules'..." && rm -rf node_modules && echo done


## Docker:
.PHONY: dk-pull dk-push dk-build dk-build-push dk-clean dk-tags dk-up \
        dk-build-up dk-down dk-logs dk-test

__DK     = docker $(DKARGS)
__DKFILE = docker-compose.yml
ifeq ($(DKENV),test)
	__DKFILE = docker-compose.test.yml
endif
ifeq ($(DKENV),ci)
	__DKFILE = docker-compose.build.yml
endif
__DKCMP  = docker-compose -f "$(__DKFILE)"
__DKCMP_VER = VERSION="$(VERSION)" $(__DKCMP)
__DKCMP_LST = VERSION=latest $(__DKCMP)

dk-pull: ## Pull latest Docker images from registry.
	@echo "Pulling latest images from registry..." && \
	 $(__DKCMP_LST) pull $(DKARGS) $(SVC)

dk-push: ## Push new Docker images to registry.
	@if git describe --exact-match --tags > /dev/null 2>&1; then \
	   echo "Pushing versioned images to registry (:$(VERSION))..." && \
	   $(__DKCMP_VER) push $(DKARGS) $(SVC); \
	 fi && \
	 echo "Pushing latest images to registry (:latest)..." && \
	 $(__DKCMP_LST) push $(DKARGS) $(SVC) && \
	 echo done

dk-build: ## Build and tag Docker images.
	@echo "Building images..." && \
	 $(__DKCMP_VER) build $(DKARGS) --parallel --compress $(SVC) && \
	 echo done && $(MAKE) dk-tags

dk-clean: ## Clean up unused Docker data.
	@echo "Cleaning unused data..." && $(__DK) system prune

dk-build-push: dk-build dk-push ## Build and push new Docker images.

dk-tags: ## Tag versioned Docker images with ':latest'.
	@echo "Tagging versioned images with ':latest'..." && \
	images="$$($(__DKCMP_VER) config | egrep image | awk '{print $$2}')" && \
	for image in $$images; do \
	  if [ -z "$$($(__DK) images -q "$$image" 2> /dev/null)" ]; then \
	    continue; \
	  fi && \
	  echo "$$image" | sed -e 's/:.*$$/:latest/' | \
	    xargs $(__DK) tag "$$image"; \
	done && \
	echo done

__DK_UP = $(__DKCMP_VER) up $(DKARGS)
dk-up: ## Start up containerized services.
	@echo "Bringing up services..." && $(__DK_UP) $(SVC) && echo done

dk-build-up: ## Build new images, then start them.
	@echo "Building and bringing up services..." && \
	 $(__DK_UP) --build $(SVC) && \
	 echo done

dk-down: ## Shut down containerized services.
	@echo "Bringing down services..." && \
	 $(__DKCMP_VER) down $(DKARGS) $(SVC) && \
	 echo done

dk-logs: ## Show logs for containerized services.
	@$(__DKCMP_VER) logs $(DKARGS) -f $(SVC)

dk-test: ## Test using 'docker-compose.test.yml'.
	$(eval __DKFILE = docker-compose.test.yml)
	@if [ -s "$(__DKFILE)" ]; then \
	   echo "Running containerized service tests..." && \
	   for svc in $$($(__DKCMP_LST) config --services); do \
	     $(eval DKARGS = --abort-on-container-exit) \
	     if ! $(__DK_UP) "$$svc"; then exit -1; fi \
	   done; \
	 fi && \
	 echo done
