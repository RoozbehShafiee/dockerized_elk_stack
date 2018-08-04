## Containerized ELK Stack based on ubuntu 16.04

FROM ubuntu:16.04

## label and credits
LABEL image="Dockerized ELK Stack - Elasticsearch Docker Image" \
      maintainer="Roozbeh Shafiee, me@roozbeh.cloud" \
      version="1.0.0-production" \
      released="August 4th, 2018" \
      reference="https://roozbeh.cloud, https://github.com/RoozbehShafiee"

## manage packages and repositories
RUN apt update && \
    apt -y install \
    openjdk-8-jdk \
    apt-transport-https \
    ca-certificates \
    wget

RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add - \
    && echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | tee -a \
    /etc/apt/sources.list.d/elastic-6.x.list

RUN apt update && \
    apt -y install \
    elasticsearch

RUN rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apt/archives/*

## manage users, files, directories and permissions
COPY ./conf_files/run.sh /
RUN chmod +x /run.sh \
    && usermod -s /bin/bash elasticsearch

## expose port
EXPOSE 9200
EXPOSE 9300

## start elasticsearch service
CMD ["/run.sh"]
