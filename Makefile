VERSION = master
UID = $(shell id -u)
GID = $(shell id -g)
DOCKER_IMAGE = pim-docs:$(VERSION)
DOCKER_RUN = docker run -it --rm -u $(UID):$(GID)

.DEFAULT_GOAL := build
.PHONY: help, build, deploy-prod, deploy-staging, docker-build

help:
	exit 1

build:
	rm -rf pim-docs-build && mkdir pim-docs-build
	$(DOCKER_RUN) -v $(PWD):/home/akeneo/pim-docs/data $(DOCKER_IMAGE) data/build.sh $(VERSION)

deploy-prod:
	exit 3

deploy-staging:
	exit 4

docker-build:
	docker build . --tag $(DOCKER_IMAGE)
