FROM debian:buster

RUN apt-get update && apt-get install -y php7.3 \
            php7.3-fpm \
            php7.3-mysql \
            curl \
            mariadb-client 

COPY ./conf/wp-config-create.sh  .
RUN chmod 0777 wp-config-create.sh 
ENTRYPOINT ["./wp-config-create.sh"]
CMD ["/usr/sbin/php-fpm7.3", "-F", "--nodaemonize"]
