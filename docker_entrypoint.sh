#!/bin/bash

cd $GITHUB_WORKSPACE

cp -R $GITHUB_WORKSPACE/* /var/www/html

cp /var/www/html/tests/setup/crons.conf /etc/cron.d/yetiforcecrm
cp /var/www/html/tests/setup/db/mysql.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
cp /var/www/html/tests/setup/nginx/www.conf /etc/nginx/sites-available/default
cp /var/www/html/tests/setup/nginx/yetiforce.conf /etc/nginx/yetiforce.conf
cp /var/www/html/tests/setup/fpm/www.conf /etc/php/$PHP_VER/fpm/pool.d/www.conf
cp /var/www/html/tests/setup/php/prod.ini /etc/php/$PHP_VER/mods-available/yetiforce.ini

ln -s /etc/php/$PHP_VER/mods-available/yetiforce.ini /etc/php/$PHP_VER/cli/conf.d/30-yetiforce.ini
ln -s /etc/php/$PHP_VER/mods-available/yetiforce.ini /etc/php/$PHP_VER/fpm/conf.d/30-yetiforce.ini

crontab /etc/cron.d/yetiforcecrm
rm /var/www/html/.user.ini
rm /var/www/html/public_html/.user.ini

chmod -R +x /var/www/html/tests/setup

/var/www/html/tests/setup/docker_entrypoint.sh
/var/www/html/tests/setup/dependency.sh

chown -R www-data:www-data /var/www/
php /var/www/html/tests/setup/docker_post_install.php

service mysql start;
service cron start
/usr/sbin/nginx -g "daemon off;" &
/etc/init.d/php$INPUT_PHP-fpm start
/usr/bin/mysqld_safe


mysql -uroot mysql;
mysqladmin password "$DB_ROOT_PASS";
echo "UPDATE mysql.user SET Password=PASSWORD('$DB_ROOT_PASS') WHERE User='root';" | mysql --user=root;
echo "DELETE FROM mysql.user WHERE User='';" | mysql --user=root;
echo "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');" | mysql --user=root;
echo "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';" | mysql --user=root;
echo "CREATE DATABASE yetiforce;" | mysql --user=root;
echo "CREATE USER 'yetiforce'@'localhost' IDENTIFIED BY '$DB_USER_PASS';" | mysql --user=root;
echo "GRANT ALL PRIVILEGES ON yetiforce.* TO 'yetiforce'@'localhost';" | mysql --user=root;
echo "FLUSH PRIVILEGES;" | mysql --user=root

printenv
