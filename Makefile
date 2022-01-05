DOCKER_REPO ?= public.ecr.aws/c1s5x5y2
IMAGE_NAME ?= butlerhq/postgres
POSTGRES_IMAGE_TAG ?= 12-alpine

.PHONY: ecr-login
ecr-login:
	@printf "Login AWS ECR Repository...\n"
	aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin $(DOCKER_REPO)

.PHONY: docker-postgres
docker-postgres:
	@printf "Build and push docker image  $(DOCKER_REPO)/$(IMAGE_NAME):$(POSTGRES_IMAGE_TAG)...\n"
	docker buildx build --platform=linux/amd64,linux/arm64 . --build-arg POSTGRES_IMAGE_TAG=$(POSTGRES_IMAGE_TAG) --push -t $(DOCKER_REPO)/$(IMAGE_NAME):$(POSTGRES_IMAGE_TAG)

	@printf "Pushing docker image  $(DOCKER_REPO)/$(IMAGE_NAME):$(POSTGRES_IMAGE_TAG)...\n"
	#docker buildx push $(DOCKER_REPO)/$(IMAGE_NAME):$(POSTGRES_IMAGE_TAG)

help: ## Display this help screen
	@grep -h -E '^[a-zA-Z_-]+(\.[a-zA-Z_-]+)*:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

