# Append the git sha unless we are doing a release
ifdef IS_RELEASE
APP_VERSION := $(shell cat version.txt)
else
APP_VERSION ?= $(shell cat version.txt)-$(shell git rev-parse --short HEAD)
endif

REGISTRY:=url.to.your.docker.repo

FACTORIO_IMAGE_NAME:=${REGISTRY}/factorio
FACTORIO_IMAGE:=${FACTORIO_IMAGE_NAME}:${APP_VERSION}
FACTORIO_IMAGE_LATEST:=${FACTORIO_IMAGE_NAME}:latest

build:
	docker build -t ${FACTORIO_IMAGE} factorio
	docker tag ${FACTORIO_IMAGE} ${FACTORIO_IMAGE_LATEST}

destroy:
	FACTORIO_IMAGE=${FACTORIO_IMAGE} docker-compose -f docker-compose.yml down -v

push: build
	docker push ${FACTORIO_IMAGE_LATEST}

# Only push latest if we are doing a release
ifdef IS_RELEASE
	docker push ${FACTORIO_IMAGE_LATEST}
endif
	@echo "Pushed version ${APP_VERSION} to registry"

run:
	FACTORIO_IMAGE=${FACTORIO_IMAGE} docker-compose -f docker-compose.yml up -d

stop:
	FACTORIO_IMAGE=${FACTORIO_IMAGE} docker-compose -f docker-compose.yml stop 

clean:
	-@docker rmi $$(docker images | grep factorio | awk '{ print $$3 }')