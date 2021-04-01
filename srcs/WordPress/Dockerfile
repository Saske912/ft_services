FROM alpine:3.12.3
EXPOSE 5050
ENV  CF="conf/"
ENV INFLUX_TOKEN=5aMY3avclofEDTRbd3tKpaWpvBPWJU7RHbXHVD7d_4Q3WtauPHc5b63aFD_NZgBO51NE3qw5_R5H_O_sozxmOg==
RUN apk update;apk add nginx wget php-fpm php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli \
php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix \
php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom py-pip
RUN echo "http://alpine.42.fr/edge/community/" >> etc/apk/repositories
RUN apk add telegraf
RUN pip install supervisor
# ADD https://dl.influxdata.com/telegraf/releases/telegraf-1.16.2_linux_amd64.tar.gz .
# RUN tar xf telegraf-1.16.2_linux_amd64.tar.gz;
#mv telegraf-1.16.2_linux_amd64 telegraf;\
#chmod +x telegraf*/*;\
#cp telegraf*/telegraf /usr/bin;
WORKDIR /home/
RUN wget https://ru.wordpress.org/latest-ru_RU.tar.gz;tar -xzvf latest-ru_RU.tar.gz;\
rm -f latest-ru_RU.tar.gz
COPY ./conf/wp-config.php wordpress/wp-config.php
WORKDIR /etc/nginx/
COPY "$CF"default.conf conf.d/
COPY conf/nginx.conf .
COPY conf/fastcgi_params .
WORKDIR /
RUN mkdir -p /run/nginx
COPY conf/www.conf /etc/php7/php-fpm.d/
COPY telegraf.conf .
COPY run.sh .
RUN adduser --disabled-password -h /home -G www-data www-data
COPY supervisord.conf .
ENTRYPOINT [ "ash" ]
CMD [ "run.sh" ]