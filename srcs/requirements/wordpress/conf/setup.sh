#!/bin/sh

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar 

mv wp-cli.phar /usr/local/bin/wp
rm -f /var/www/html/wp-config.php
cp ./wp-config.php /var/www/html/wp-config.php

/usr/local/bin/wp core download --allow-root 
/usr/local/bin/wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root 
/usr/local/bin/wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root
/usr/local/bin/wp db check --allow-root
sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php83/php-fpm.d/www.conf

mkdir -p /run/php

/usr/sbin/php-fpm83 -F