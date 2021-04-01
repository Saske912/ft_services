#!/bin/ash

if [[ ! -d /var/lib/mysql/mysql ]]; then
    openrc default
    /etc/init.d/mariadb setup
   # mv /var/lib/mysql/* /home/data
    rc-service mariadb start
    mysql < conf.sql
    sed "s/localhost/$WP/g; s/root/www-data/g;" copy.wp_pma.sql > wp_pma.sql
    mysql wp_pma < wp_pma.sql
    rc-service mariadb stop
fi
supervisord -c supervisord.conf
#/usr/bin/mysql_install_db --user=root --datadir="/var/lib/mysql"
#mysqld -u root --datadir='/var/lib/mysql' & telegraf --config telegraf.conf