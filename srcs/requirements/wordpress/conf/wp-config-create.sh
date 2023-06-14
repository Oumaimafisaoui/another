#!/bin/sh

config_file="/var/www/html/wp-config.php"

if [ ! -f "$config_file" ]; then
    mkdir -p /var/www/html
    chown -R www-data:www-data /var/www/html
    cd /var/www/html

    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp

    wp core download --locale=en_US  --allow-root
    
    wp config create \
        --dbname="$DB_NAME" \
        --dbuser="$DB_USER" \
        --dbpass="$DB_PASS" \
        --dbhost="$MARIA" \
        --allow-root \
        --skip-check

    wp core install --url=${WP_LOCAL}  --title="$WP_TITLE" --admin_user=${AD_USER} --admin_password=${AD_PASS} --admin_email=${AD_EMAIL} --allow-root 
    wp theme install twentysixteen --activate --allow-root
    mkdir -p /run/php/
    chown root:root /run/php/ && chmod 775 /run/php/
    sed -i "s|listen = /run/php/php7.3-fpm.sock|listen = 9000|" "/etc/php/7.3/fpm/pool.d/www.conf"
fi

exec "$@"
