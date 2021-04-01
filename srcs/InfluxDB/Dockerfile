FROM alpine:3.12.3
EXPOSE 8086
WORKDIR /
ENV IF=localhost
#ENV INFLUXD_ENGINE_PATH=/home
#ENV INFLUXD_BOLT_PATH=/home/influxd.bolt
#ENV INFLUXD_LOG_LEVEL=debug
ENV INFLUX_TOKEN=5aMY3avclofEDTRbd3tKpaWpvBPWJU7RHbXHVD7d_4Q3WtauPHc5b63aFD_NZgBO51NE3qw5_R5H_O_sozxmOg==
RUN apk update; apk add curl gnupg py-pip
RUN echo "http://alpine.42.fr/edge/community/" >> etc/apk/repositories
RUN apk add telegraf
RUN pip install supervisor
VOLUME [ "/sys/fs/cgroup" ]
ADD https://dl.influxdata.com/influxdb/releases/influxdb2-2.0.3_linux_amd64.tar.gz .
RUN tar -xzvf influxdb2-2.0.3_linux_amd64.tar.gz;\
mv influxdb2-2.0.3_linux_amd64 influxdb;\
curl -s https://repos.influxdata.com/influxdb2.key | gpg --import -
ADD https://dl.influxdata.com/influxdb/releases/influxdb2-2.0.3_linux_amd64.tar.gz.asc .
RUN gpg --verify influxdb2-2.0.3_linux_amd64.tar.gz.asc influxdb2-2.0.3_linux_amd64.tar.gz;\
cp influxdb/influx influxdb/influxd /usr/local/bin/
COPY run_influxd.sh .
#COPY file.yaml .
COPY telegraf.conf .
RUN mkdir -p /root/.influxdbv2
COPY influxd.bolt .
COPY supervisord.conf .
ENTRYPOINT [ "ash" ]
CMD [ "run_influxd.sh" ]