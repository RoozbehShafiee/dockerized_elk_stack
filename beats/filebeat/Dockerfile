FROM ubuntu:18.04

## label and credits
LABEL image="Dockerized ELK Stack - Filebeat Docker Image" \
      maintainer="Roozbeh Shafiee, me@roozbeh.cloud" \
      version="1.0.0-production" \
      released="August 4th, 2018" \
      reference="https://roozbeh.cloud, https://github.com/RoozbehShafiee"

## manage packages and repositories
RUN apt update \
    && apt -y dist-upgrade \
    && apt -y install \
              apt-transport-https \
              ca-certificates \
              gnupg2 \
              wget

RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add - \
    && echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | tee -a \
    /etc/apt/sources.list.d/elastic-6.x.list

RUN apt update && \
    apt -y install \
           filebeat \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apt/archives/*

## manage files, directories and permissions
ADD ./conf_files/ssl /etc/filebeat/ssl
ADD ./conf_files/filebeat.yml /etc/filebeat/filebeat.yml
ADD ./conf_files/filebeat.reference.yml /etc/filebeat/filebeat.reference.yml
ADD ./conf_files/entrypoint.sh /
RUN chmod +x /entrypoint.sh

## start elasticsearch service
CMD ["/entrypoint.sh"]
