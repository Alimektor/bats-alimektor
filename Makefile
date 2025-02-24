LIBDIR=$(DESTDIR)/usr/local/lib/bats
LIBNAME=bats-alimektor

.PHONY: all install uninstall docs check test docker docker-build-test docker-test docker-docs-build docker-docs-create docker-docs help

all: install

## Set variables to install / uninstall to ~/.bats/libs/
ifeq ($(LOCAL), true)
LIBDIR=$(HOME)/.bats/libs
endif

install: ## Install bats-alimektor (Set LOCAL=true to install to ~/.bats/libs/)
	@echo "Installing $(LIBNAME) to $(LIBDIR)..."
	mkdir -p $(LIBDIR)
	rm -rf $(LIBDIR)/$(LIBNAME)
	cp -r . $(LIBDIR)/$(LIBNAME)
	@echo "Installed $(LIBNAME) to $(LIBDIR)..."

uninstall: ## Uninstall bats-alimektor (Set LOCAL=true to install to ~/.bats/libs/)
	@echo "Uninstalling $(LIBNAME) from $(LIBDIR)..."
	rm -rf $(LIBDIR)/$(LIBNAME)
	@echo "Uninstalled $(LIBNAME) from $(LIBDIR)..."

docs: ## Create docs
	@echo "Creating docs..."
	docs/create-docs.sh
	@echo "Created docs successfully..."

check: ## Check bats-alimektor
	@echo "Checking bats-alimektor..."
	pre-commit install
	pre-commit run --all-files
	@echo "Checked bats-alimektor successfully..."

test: ## Test bats-alimektor
	@echo "Running bats tests..."
	bats -r tests/
	@echo "Ran bats tests successfully..."

docker: ## Build docker image
	@echo "Building docker image..."
	docker build -t bats-alimektor .
	@echo "Built docker image..."

docker-build-test: docker
	@echo "Building docker image for tests..."
	docker build -t bats-alimektor-test -f tests/Dockerfile .
	@echo "Built docker image for tests..."

docker-test: docker-build-test ## Test bats-alimektor in the docker image
	@echo "Running docker image..."
	docker run bats-alimektor-test bats -r tests/
	@echo "Ran docker image successfully..."

docker-docs-build:
	@echo "Building docker image..."
	docker build -t bats-alimektor-docs -f docs/Dockerfile .
	@echo "Built docker image..."

docker-docs-create:
	@echo "Running docker image..."
	docker run -v ${PWD}:/app bats-alimektor-docs
	@echo "Ran docker image successfully..."

docker-docs: docker-docs-build docker-docs-create ## Create docs in docker image

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[1;32m%-15s \033[1;33m%s\033[0m\n", $$1, $$2}'
