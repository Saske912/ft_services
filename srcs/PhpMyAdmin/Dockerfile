FROM alpine:3.12.3
ENV PA="phpmyadmin"
ENV NC="conf/nginx/"
ENV INFLUX_TOKEN=5aMY3avclofEDTRbd3tKpaWpvBPWJU7RHbXHVD7d_4Q3WtauPHc5b63aFD_NZgBO51NE3qw5_R5H_O_sozxmOg==
RUN apk add $PA php-mbstring php-gettext php-fpm nginx openssl py-pip
RUN echo "http://alpine.42.fr/edge/community/" >> etc/apk/repositories
RUN apk add telegraf
RUN pip install supervisor
WORKDIR /usr/share/webapps/
COPY conf/"$PA"/config.inc.php "$PA"/
RUN chmod 665 "$PA"/config.inc.php
WORKDIR /etc/nginx/
COPY "$NC"nginx.php.conf sites-available/
COPY "$NC"nginx.conf .
WORKDIR /etc/php7/
COPY conf/php-fpm/www.conf php-fpm.d/
WORKDIR /
COPY ssl/ssl-params.conf etc/nginx/snippets/
COPY ssl/self-signed.conf etc/nginx/snippets/
RUN yes "" | openssl req -x509 -nodes -newkey rsa:2048 -keyout /etc/ssl/nginx.key -out /etc/ssl/nginx.crt ;
RUN mkdir /run/nginx; mkdir -p /usr/share/webapps/phpmyadmin/tmp/; chown -R nginx /usr/share/webapps/phpmyadmin/
COPY conf/"$PA"/config.inc.php /etc/"$PA"/
COPY conf/php/php.ini /etc/php7/
COPY run.sh .
RUN chmod 665 run.sh
EXPOSE 5000
COPY telegraf.conf .
COPY supervisord.conf .
ENTRYPOINT [ "ash" ]
CMD [ "run.sh" ]