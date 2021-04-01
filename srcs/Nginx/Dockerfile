FROM alpine:3.12
COPY site/* home/
WORKDIR /
ENV WP=localhost
ENV PMA=localhost
ENV INFLUX_TOKEN=5aMY3avclofEDTRbd3tKpaWpvBPWJU7RHbXHVD7d_4Q3WtauPHc5b63aFD_NZgBO51NE3qw5_R5H_O_sozxmOg==
RUN echo "http://alpine.42.fr/edge/community/" >> etc/apk/repositories
RUN apk update; apk add pcre-dev openssl-dev zlib zlib-dev openssl make \
openssh gettext telegraf g++ py-pip;
ADD https://nginx.org/download/nginx-1.19.6.tar.gz .
RUN tar -xzvf nginx-1.19.6.tar.gz
RUN pip install supervisor
RUN openssl req -x509 -newkey rsa:2048 \
    	-keyout /etc/ssl/private/service.key \
    	-out /etc/ssl/certs/service.crt -nodes -days 365 \
    	-subj '/C=RU/ST=Kazan/O=21school/OU=pfile/CN=nginx'
EXPOSE 80 443 22
COPY run_nginx.sh .
COPY nginx.conf usr/local
COPY default .
COPY telegraf.conf .
RUN echo "root:sky32" | chpasswd
RUN ssh-keygen -A
COPY sshd_config /etc/ssh
RUN cd /nginx-1.19.6;./configure --with-http_stub_status_module \
	--sbin-path=/bin \
 	--prefix=/usr/local \
	--conf-path=nginx.conf \
	--with-http_ssl_module \
	--with-http_realip_module \
	--with-http_addition_module \
	--with-http_sub_module; make install
RUN adduser nginx --disabled-password
COPY supervisord.conf .
ENTRYPOINT [ "ash" ]
CMD [ "run_nginx.sh" ]