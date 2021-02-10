TARGETS := $(shell ls scripts)
PWD := $(shell pwd)

.dapper:
	@echo Downloading dapper
	@curl -sL https://releases.rancher.com/dapper/latest/dapper-`uname -s`-`uname -m` > .dapper.tmp
	@@chmod +x .dapper.tmp
	@./.dapper.tmp -v
	@mv .dapper.tmp .dapper

start:  ## Run Developer k3s
	@echo "Start Docker container k3os..."
	@#docker build -t k3s-app .
	@docker run --net=host --privileged --rm \
		-v $(PWD)/cmd/:/go/src/github.com/rancher/k3os/cmd/ \
		-v $(PWD)/pkg/:/go/src/github.com/rancher/k3os/pkg/ \
		-v $(PWD)/vendor/:/go/src/github.com/rancher/k3os/vendor/ \
		-it k3s-app:latest bash

$(TARGETS): .dapper
	@rm -rf ./dist ./build
	./.dapper $@

.DEFAULT_GOAL := default

.PHONY: start $(TARGETS)
