#!/bin/sh

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar 

mv wp-cli.phar /usr/local/bin/wp
rm -f /var/www/html/wp-config.php

cd /var/www/html

MB_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_USR=$(awk -F: '/administrator/ {print $1}' /run/secrets/credentials)
WP_ADMIN_PWD=$(awk -F: '/administrator/ {print $2}' /run/secrets/credentials)
WP_ADMIN_EMAIL=$(awk -F: '/administrator/ {print $3}' /run/secrets/credentials)
WP_USR=$(awk -F: '/author/ {print $1}' /run/secrets/credentials)
WP_MDP=$(awk -F: '/author/ {print $2}' /run/secrets/credentials)
WP_EMAIL=$(awk -F: '/author/ {print $3}' /run/secrets/credentials)

/usr/local/bin/wp core download --allow-root 
/usr/local/bin/wp config create	--dbname=${MB_DATABASE} --dbuser=${MB_USER} --dbpass=${MB_PASSWORD} --dbhost="mariadb" --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
/usr/local/bin/wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
/usr/local/bin/wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_MDP --allow-root
sed -i 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/g' /etc/php83/php-fpm.d/www.conf

mkdir -p /run/php

/usr/sbin/php-fpm83 -F -R