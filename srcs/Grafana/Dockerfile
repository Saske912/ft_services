FROM alpine:3.12.3
WORKDIR /
ENV GRAFANA_IP=localhost
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community/" >> etc/apk/repositories
ENV INFLUX_TOKEN=5aMY3avclofEDTRbd3tKpaWpvBPWJU7RHbXHVD7d_4Q3WtauPHc5b63aFD_NZgBO51NE3qw5_R5H_O_sozxmOg==
EXPOSE 3000
RUN apk add grafana py-pip telegraf
RUN apk add supervisor
COPY grafana.sh .
COPY grafana.ini /etc
RUN mkdir -p var/lib/grafana
COPY grafana.db /var/lib/grafana
RUN mkdir -p /var/log/grafana
COPY telegraf.conf .
COPY supervisord.conf .
#WORKDIR /usr/share/grafana
ENTRYPOINT [ "ash" ]
CMD [ "grafana.sh" ]