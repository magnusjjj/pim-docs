VERSION = master
UID = $(shell id -u)
GID = $(shell id -g)
SSH_AUTH_SOCK = $(shell echo $$SSH_AUTH_SOCK)
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
	@echo $(SSH_AUTH_SOCK)
	docker run -it --rm -v $(SSH_AUTH_SOCK):/ssh-auth.sock:ro -e SSH_AUTH_SOCK=/ssh-auth.sock -v $(PWD):/home/akeneo/pim-docs/data $(DOCKER_IMAGE) bash 
	#rsync -e "ssh -p 2348" -avz /home/akeneo/pim-docs/data/pim-docs-build/* akeneo@docs-staging.core.akeneo.com:/var/www/${VERSION}

docker-build:
	docker build . --tag $(DOCKER_IMAGE)
