
.PHONY: all ps wp-logs db-logs show-db down stop start clean fclean re

NAME = inception
DOCKER_COMPOSE =./srcs/docker-compose.yaml
DATA_PATH =./data

all:
	@sudo mkdir -p $(DATA_PATH)/mariadb
	@sudo mkdir -p $(DATA_PATH)/wordpress
	sudo docker compose -f $(DOCKER_COMPOSE) up -d --build

ps: 
	sudo docker compose -f $(DOCKER_COMPOSE) ps

wp-logs:
	sudo docker compose -f $(DOCKER_COMPOSE) logs wordpress

db-logs:
	sudo docker compose -f $(DOCKER_COMPOSE) logs mariadb

nx-logs:
	sudo docker compose -f $(DOCKER_COMPOSE) logs nginx

down:
	sudo docker compose -f $(DOCKER_COMPOSE) down

stop:
	sudo docker compose -f $(DOCKER_COMPOSE) stop

start:
	sudo docker compose -f $(DOCKER_COMPOSE) start

clean:
	sudo docker compose -f $(DOCKER_COMPOSE) down --rmi all -v

show-db:
	sudo docker compose -f $(DOCKER_COMPOSE) exec mariadb mysql -u root -p

vol: 
	@echo "==================== mariadb data ===================="
	sudo docker volume inspect srcs_mariadb_data
	@echo "==================== wordpress data ===================="
	sudo docker volume inspect srcs_wordpress_data

fclean: clean
	sudo rm -rf $(DATA_PATH)/mariadb/
	sudo rm -rf $(DATA_PATH)/wordpress/

re: fclean all

