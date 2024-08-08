
volumes= ~/goinfre/data/www ~/goinfre/data/database

all: setup
	@docker compose -f srcs/docker-compose.yml up --build

setup:
	@sudo rm -rf $(volumes)
	@sudo mkdir -p $(volumes)

down:
	@docker compose -f srcs/docker-compose.yml down

re:
	@docker compose -f srcs/docker-compose.yml up --build

clean:
	@docker compose -f srcs/docker-compose.yml down
	@docker system prune --volumes --force
	@docker image prune --all --force

.PHONY: all re down clean