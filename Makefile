NAME = ./srcs/docker-compose.yml 
run : 
	mkdir -p ${HOME}/data/WP ${HOME}/data/DB
	docker-compose -f ${NAME} up --build 
clean : 
	docker-compose -f ${NAME} down -v --rmi all 
	sudo rm -rf ${HOME}/data/WP  ${HOME}/data/DB ${HOME}/data/ 
	docker system prune -af

