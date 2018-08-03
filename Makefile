# Makefile

LAST_IMAGE=$(shell docker images overware/minecraft-forge | sort | tail -1 | awk 'BEGIN{OFS=":"}{print $$1,$$2}')

.PHONY: all build forge-latest clean run rund

all: build ## Build by default released minecraft forge server docker image

build: ## Build last released minecraft forge server docker image
	docker build -t overware/minecraft-forge ./

forge-latest: ## Build last forge-latest minecraft server docker image
	docker build --build-arg FORGE_TARGET=latest -t overware/minecraft-forge:forge-latest ./

clean: ## Remove running minecraft forge containers and minecraft forge images
	if docker ps -a --filter ancestor=overware/minecraft-forge | grep -q minecraft; then docker rm -f `docker ps -a --filter ancestor=overware/minecraft-forge | grep minecraft | awk '{print $$NF}'`; fi
	if docker images overware/minecraft-forge:latest | grep -q minecraft; then docker rmi overware/minecraft-forge:latest; fi
	if docker images overware/minecraft-forge:forge-latest | grep -q minecraft; then docker rmi overware/minecraft-forge:forge-latest; fi

run: ## Run minecraft server
	docker run -ti --rm -p 25565:25565 --name minecraft-forge $(LAST_IMAGE)

rund: ## Run minecraft server in daemon mode
	docker run -d -p 25565:25565 --name minecraft-forge $(LAST_IMAGE)

help:
	@grep -hE '(^[\.a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-15s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'
