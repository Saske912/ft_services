#!/bin/sh

minikube delete
minikube --vm-driver=virtualbox start
minikube addons enable metallb
kubectl apply -f srcs/metallb.yaml
kubectl create -f srcs/Nginx/nginx_service.yaml
kubectl create -f srcs/ftps/ftps_service.yaml
kubectl create -f srcs/PhpMyAdmin/phpmyadmin_service.yaml
kubectl create -f srcs/Grafana/grafana_service.yaml
kubectl create -f srcs/WordPress/wordpress_service.yaml
kubectl create -f srcs/Mysql/mysql_service.yaml
kubectl create -f srcs/InfluxDB/influxdb_service.yaml

#ConfigMap
sleep 50
kubectl create configmap service-ip --from-literal=IP=\
"$(kubectl get svc nginx|grep nginx|tr -s ' ' ':'|cut -d: -f4)"

#Docker
eval $(minikube docker-env)
docker build -t wordpress srcs/WordPress
docker build -t phpmyadmin srcs/PhpMyAdmin
docker build -t nginx srcs/Nginx
docker build -t mysql srcs/Mysql
docker build -t influxdb srcs/InfluxDB
docker build -t grafana srcs/Grafana
docker build -t ftps srcs/ftps
eval $(minikube docker-env -u)

#Volumes
kubectl create -f srcs/Mysql/mysql_pv.yaml
kubectl create -f srcs/Mysql/mysql_pvc.yaml
kubectl create -f srcs/InfluxDB/influxdb_pv.yaml
kubectl create -f srcs/InfluxDB/influxdb_pvc.yaml

#Deplomyments
kubectl create -f srcs/WordPress/wordpress.yaml
kubectl create -f srcs/PhpMyAdmin/phpmyadmin.yaml
kubectl create -f srcs/Nginx/nginx.yaml
kubectl create -f srcs/Mysql/mysql.yaml
kubectl create -f srcs/InfluxDB/influxdb.yaml
kubectl create -f srcs/Grafana/grafana.yaml
kubectl create -f srcs/ftps/ftps.yaml

#Dashboard
minikube dashboard