FROM alpine:3.12.3
WORKDIR /
ENV INFLUX_TOKEN=5aMY3avclofEDTRbd3tKpaWpvBPWJU7RHbXHVD7d_4Q3WtauPHc5b63aFD_NZgBO51NE3qw5_R5H_O_sozxmOg==
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community/" >> etc/apk/repositories
RUN apk update;apk add telegraf vsftpd openssl py-pip; mkdir etc/telegraf;
COPY telegraf.conf .
RUN pip install supervisor
COPY vsftpd.conf /etc/
EXPOSE 21 30021 30020
RUN openssl req -x509 -newkey rsa:2048 \
    	-keyout /etc/ssl/private/service.key \
    	-out /etc/ssl/certs/service.crt -nodes -days 365 \
    	-subj "/C=RU/ST=Kazan/O=21school/OU=pfile/CN=${IP}"
COPY ftps_run.sh .
RUN adduser pfile --disabled-password; echo "pfile:sky32" | chpasswd
RUN mkdir -p /var/run/vsftpd
RUN echo "root:sky32" | chpasswd
COPY supervisord.conf .
ENTRYPOINT [ "ash"]
CMD [ "ftps_run.sh" ]