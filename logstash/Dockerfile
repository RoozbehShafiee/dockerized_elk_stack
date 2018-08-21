FROM ubuntu:18.04

## label and credits
LABEL image="Dockerized ELK Stack - Logstash Docker Image" \
      maintainer="Roozbeh Shafiee, me@roozbeh.cloud" \
      version="1.0.0-production" \
      released="August 4th, 2018" \
      reference="https://roozbeh.cloud, https://github.com/RoozbehShafiee"

## set environment variables
ENV GOSU_VERSION=1.10 \
    PATH=/usr/share/logstash/bin:$PATH \
    LS_SETTINGS_DIR=/etc/logstash

## manage packages and repositories
RUN apt update \
    && apt -y dist-upgrade \
    && apt -y install \
              openjdk-8-jdk \
              openssl \
              apt-transport-https \
              ca-certificates \
              libzmq5 \
              gnupg2 \
              wget

RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add - \
    && echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | tee -a \
    /etc/apt/sources.list.d/elastic-6.x.list

RUN apt update \
    && apt install -y \
           logstash \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apt/archives/*

## manage files, directories and permissions
ADD ./conf_files/ssl /etc/logstash/
ADD ./conf_files/filebeat-input.conf /etc/logstash/conf.d/filebeat-input.conf
ADD ./conf_files/syslog-filter.conf /etc/logstash/conf.d/syslog-filter.conf
ADD ./conf_files/output-elasticsearch.conf /etc/logstash/conf.d/output-elasticsearch.conf
ADD ./conf_files/entrypoint.sh /
RUN chmod +x /entrypoint.sh

## expose port
EXPOSE 5443

## start elasticsearch service
CMD ["/entrypoint.sh"]
