FROM alpine:3.12.3
WORKDIR /
ENV WP=localhost
ENV MYSQL_USER=root
ENV MYSQL_ROOT_PASSWORD=Saske912
ENV INFLUX_TOKEN=5aMY3avclofEDTRbd3tKpaWpvBPWJU7RHbXHVD7d_4Q3WtauPHc5b63aFD_NZgBO51NE3qw5_R5H_O_sozxmOg==
RUN echo "http://alpine.42.fr/edge/community/" >> etc/apk/repositories
RUN apk update && apk add py-pip mysql mysql-client openrc telegraf
COPY copy.wp_pma.sql .
RUN pip install supervisor
COPY conf.sql .
COPY run_mysql.sh .
COPY telegraf.conf .
COPY mariadb-server.cnf etc/my.cnf
RUN mkdir run/mysqld ; chmod 777 run_mysql.sh
EXPOSE 3306
COPY supervisord.conf .
#RUN mkdir -p /home/data; chmod 777 "/home/data/"
ENTRYPOINT [ "ash" ]
CMD [ "run_mysql.sh" ]