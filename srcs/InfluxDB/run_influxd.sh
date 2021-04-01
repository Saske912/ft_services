#!/bin/ash

#influx setup -f -b services --host http://influxdb:8086 -o school21 -p saveli12 -t $INFLUX_TOKEN -u sky
#influx telegrafs create -f telegraf.conf -n services -o school21 -t $INFLUX_TOKEN
#influx bucket create -n grafana
#influx bucket create -n phpmyadmin
# if [[ ! -d /home/check ]]; then
#     mkdir -p /home/check;
#     mv influxd.bolt /home/
# fi
#sleep infinity
#influxd & telegraf --config telegraf.conf
cp influxd.bolt /root/.influxdbv2
supervisord -c supervisord.conf