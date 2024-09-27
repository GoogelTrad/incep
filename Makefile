
volumes= ~/data/www ~/data/database

all: setup
	@docker compose -f srcs/docker-compose.yml up --build

setup:
	@mkdir -p $(volumes)

down:
	@docker compose -f srcs/docker-compose.yml down

re:
	@docker compose -f srcs/docker-compose.yml up --build

clean:
	@sudo rm -rf $(volumes)
	@docker compose -f srcs/docker-compose.yml down
	@docker system prune -f -a

.PHONY: all re down clean