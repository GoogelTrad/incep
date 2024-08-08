#!/bin/sh

/usr/bin/mysql_install_db --user=root --basedir=/usr --datadir=/var/lib/mysql
/usr/bin/mysqld --user=root --datadir=/var/lib/mysql & sleep 2

mysql -e "CREATE DATABASE IF NOT EXISTS \`${MB_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${MB_USER}\`@'localhost' IDENTIFIED BY '${MB_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${MB_DATABASE}\`.* TO \`${MB_USER}\`@'%' IDENTIFIED BY '${MB_PASSWORD}';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MB_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

pkill mysqld
/usr/bin/mysqld --user=root --datadir=/var/lib/mysql