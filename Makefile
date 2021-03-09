# SHELL=/bin/bash -o pipefail
# SHELL = /bin/bash

.ONESHELL:
.SHELL := /bin/bash

BOLD=$(shell tput bold)
RED=$(shell tput setaf 1)
GREEN=$(shell tput setaf 2)
YELLOW=$(shell tput setaf 3)
RESET=$(shell tput sgr0)

CURRENT_DIR = $$(pwd)
UNAME := $(shell uname)
BUILD_DATE := $(shell date +%Y%m%d-%H%M)
VERSION_FILE=./VERSION

ifneq (,$(wildcard .env))
	include .env
	export $(shell sed 's/=.*//' .env)
	# export
endif

# TARGETS := $(shell ls scripts)
TARGETS := $(shell ls scripts | grep -vE 'clean|dev|run|help|release*|build-moby|run-moby')

#help: .checker
help:
	@echo "\n$(GREEN)Available commands$(RESET)"
	@echo "---------------------------------------------------------------------"
	@grep -h -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo "----------------------------------------------------------------------------"
	@#echo "GOPATH: ${GOPATH}"
	@./scripts/help
	@echo " "

.checker:
ifeq ($(shell test -e $(VERSION_FILE) && echo -n yes),yes)
	@$(eval VERSION=$(shell cat $(VERSION_FILE)))
else
	@echo File $(VERSION_FILE) does not exist
	@exit 0;
endif

info:   ## for developer information
	@echo "---------------------------------------------------------------------"
	# @echo "$(GREEN)$(RESET)"
	@echo "$(GREEN)AWS_ACCESS_KEY:$(RESET) ${AWS_ACCESS_KEY}"
	@echo "$(GREEN)AWS CLI profile:$(RESET) ${AWS_PROFILE}"
	@echo "$(GREEN)AWS region:$(RESET) ${REGION}"
	@echo "---------------------------------------------------------------------"
	@env

run-dev: ## Run QEMU 
	@echo "exit from QEMU Ctrl+a c"
	@echo "(qemu) q"
	@echo " "
	@echo "Password: rancher"
	@echo " "
	@./scripts/run-qemu k3os.password=rancher k3os.debug=true

run-live: ## Run live cd boot
	@echo "exit from QEMU Ctrl+a c"
	@echo "(qemu) q"
	@echo " "
	@echo "sudo K3OS_INSTALL_NO_REBOOT=true K3OS_INSTALL_DISABLE_IPV6=true k3os install"
	@./scripts/run-qemu k3os.mode=live k3os.debug=true

packer-proxmox: ## Build Proxmox
	@ echo "Start build proxmox server: ${pve_server}"
	@cd ./package/packer/proxmox/ \
		&& PACKER_LOG=1 packer build -debug -on-error=ask -var-file=vars.json template.json

dev: ## For development
	@./scripts/dev

clean: ## Clean docker images
	@./scripts/clean

.dapper:
	@echo Downloading dapper
	@curl -sL https://releases.rancher.com/dapper/latest/dapper-`uname -s`-`uname -m` > .dapper.tmp
	@@chmod +x .dapper.tmp
	@./.dapper.tmp -v
	@mv .dapper.tmp .dapper

$(TARGETS): .dapper
	@rm -rf ./dist ./build
	./.dapper $@

.DEFAULT_GOAL := default

.PHONY: $(TARGETS)
# .PHONY: help info run-live packer-proxmox $(TARGETS)
