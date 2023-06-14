#!/bin/sh
cd /etc/mysql/mariadb.conf.d/
sed -i "s/127.0.0.1/0.0.0.0/g" 50-server.cnf

if [ ! -d /var/lib/mysql/$DB_NAME ]; then
    service mysql start
    sleep 5
    mysql  -e "CREATE DATABASE ${DB_NAME};"
    mysql  -e "CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';"
    mysql  -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"
    mysql  -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${PS_ROOT}';"
    mysql  -e "FLUSH PRIVILEGES;" -p${PS_ROOT}

    mysqladmin shutdown -p${PS_ROOT}
fi
mysqld_safe --console
