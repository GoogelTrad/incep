#!/bin/sh

mkdir -p /var/www/
mkdir -p /var/www/html

cd /var/www/html

rm -rf *

#dowload wordpress (php-archive) from the git
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar 

#download the lastest version of wordpress
mv wp-cli.phar /usr/local/bin/wp
wp core download --allow-root


#change line in wpconfig to connect with the database
mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sed -i -r "s/database/$MB_DATABASE/1" wp-config.php
sed -i -r "s/database_user/$MB_USER/1" wp-config.php
sed -i -r "s/passwod/$MB_PASSWORD/1" wp-config.php
sed -i -r "s/localhost/mariadb/1" wp-config.php


#install wordpress and sets up the basic config + creates new user + install astra theme for the site
wp core install --url=$DOMAIN_NAME/ --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root
wp theme install astra --activate --allow-root
sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf

mkdir -p /run/php
wp redis enable --allow-root

#starts php service in the background
/usr/sbin/php-fpm -F