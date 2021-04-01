#!bin/ash

#sleep infinity
#grafana-server --config /etc/grafana.ini --homepath /usr/share/grafana & \
#telegraf --config telegraf.conf
supervisord -c supervisord.conf