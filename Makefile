ORG   := matthieuberger
NAME    := postgres-multi-db
REPO   := ${ORG}/${NAME}
IMG    := ${REPO}:${TAG}
LATEST := ${REPO}:latest
POSTGRES_IMAGE_TAG ?= 14-alpine

.PHONY: login push
login: ## Login to docker hub
	docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}

push: login
	@printf "Build and push docker image  $(REPO):$(POSTGRES_IMAGE_TAG)...\n"
	docker buildx build --platform=linux/amd64,linux/arm64 . --build-arg POSTGRES_IMAGE_TAG=$(POSTGRES_IMAGE_TAG) --push -t $(REPO):$(POSTGRES_IMAGE_TAG)

	@printf "Pushing docker image  $(REPO):$(POSTGRES_IMAGE_TAG)...\n"
	#docker buildx push $(REPO):$(POSTGRES_IMAGE_TAG)

help: ## Display this help screen
	@grep -h -E '^[a-zA-Z_-]+(\.[a-zA-Z_-]+)*:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

