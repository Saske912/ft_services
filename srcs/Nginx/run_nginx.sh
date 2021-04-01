#!/bin/ash

echo "staring Nginx"
envsubst '\$IP' < default > home/default;
nginx -t
#/usr/sbin/sshd & nginx & telegraf --config ../telegraf.conf
supervisord -c supervisord.conf