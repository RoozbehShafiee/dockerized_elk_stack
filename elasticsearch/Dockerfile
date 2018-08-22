FROM ubuntu:18.04

## label and credits
LABEL image="Dockerized ELK Stack - Elasticsearch Docker Image" \
      maintainer="Roozbeh Shafiee, me@roozbeh.cloud" \
      version="1.0.0-production" \
      released="August 4th, 2018" \
      reference="https://roozbeh.cloud, https://github.com/RoozbehShafiee"

## manage packages and repositories
RUN apt update \
    && apt -y dist-upgrade \
    && apt -y install \
              openjdk-8-jdk \
              apt-transport-https \
              ca-certificates \
              gnupg2 \
              wget

RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add - \
    && echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | tee -a \
    /etc/apt/sources.list.d/elastic-6.x.list

RUN apt update && \
    apt -y install \
           elasticsearch \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apt/archives/*

## manage files, directories and permissions
ADD ./conf_files/entrypoint.sh /
RUN chmod +x /entrypoint.sh \
    && usermod -s /bin/bash elasticsearch

## expose ports
EXPOSE 9200 9300

## start elasticsearch service
CMD ["/entrypoint.sh"]
