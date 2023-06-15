FROM debian:buster

RUN apt-get update && apt-get install -y mariadb-server
COPY conf/db.sh /etc/mysql/db.sh
RUN chmod +x /etc/mysql/db.sh

ENTRYPOINT ["/etc/mysql/db.sh"]
