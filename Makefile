LIBDIR=$(DESTDIR)/usr/local/lib/bats
LIBNAME=bats-alimektor

.PHONY: all install uninstall docs check test docker docker-build-test docker-test docker-docs-build docker-docs-create docker-docs help

all: install

## Set variables to install / uninstall to ~/.bats/libs/
ifeq ($(LOCAL), true)
LIBDIR=$(HOME)/.bats/libs
endif

install: ## Install bats-alimektor (Set LOCAL=true to install to ~/.bats/libs/)
	$(info "Installing $(LIBNAME) to $(LIBDIR)...")
	mkdir -p $(LIBDIR)
	rm -rf $(LIBDIR)/$(LIBNAME)
	cp -r . $(LIBDIR)/$(LIBNAME)
	$(info "Installed $(LIBNAME) to $(LIBDIR)...")

uninstall: ## Uninstall bats-alimektor (Set LOCAL=true to install to ~/.bats/libs/)
	$(info "Uninstalling $(LIBNAME) from $(LIBDIR)...")
	rm -rf $(LIBDIR)/$(LIBNAME)
	$(info "Uninstalled $(LIBNAME) from $(LIBDIR)...")

docs: ## Create docs
	$(info "Creating docs...")
	docs/create-docs.sh
	$(info "Created docs successfully...")

check: ## Check bats-alimektor
	$(info "Checking bats-alimektor...")
	pre-commit install
	pre-commit run --all-files
	$(info "Checked bats-alimektor successfully...")

test: ## Test bats-alimektor
	$(info "Running bats tests...")
	bats -r tests/
	$(info "Ran bats tests successfully...")

docker: ## Build docker image
	$(info "Building docker image...")
	docker build -t bats-alimektor .
	$(info "Built docker image...")

docker-build-test: docker
	$(info "Building docker image for tests...")
	docker build -t bats-alimektor-test -f tests/Dockerfile .
	$(info "Built docker image for tests...")

docker-test: docker-build-test ## Test bats-alimektor in the docker image
	$(info "Running docker image...")
	docker run bats-alimektor-test bats -r tests/
	$(info "Ran docker image successfully...")

docker-docs-build:
	$(info "Building docker image...")
	docker build -t bats-alimektor-docs -f docs/Dockerfile .
	$(info "Built docker image...")

docker-docs-create:
	$(info "Running docker image...")
	docker run -v ${PWD}:/app bats-alimektor-docs
	$(info "Ran docker image successfully...")

docker-docs: docker-docs-build docker-docs-create ## Create docs in docker image

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[1;32m%-15s \033[1;33m%s\033[0m\n", $$1, $$2}'
