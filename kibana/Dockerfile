FROM ubuntu:18.04

## label and credits
LABEL image="Dockerized ELK Stack - Kibana Docker Image" \
      maintainer="Roozbeh Shafiee, me@roozbeh.cloud" \
      version="1.0.0-production" \
      released="August 4th, 2018" \
      reference="https://roozbeh.cloud, https://github.com/RoozbehShafiee"

## manage packages and repositories
RUN apt-get update \
    && apt-get -y dist-upgrade \
    && apt-get -y install \
                  openjdk-8-jdk \
                  apt-transport-https \
                  ca-certificates \
                  gnupg2 \
                  wget

RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add - && \
    echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | tee -a \
    /etc/apt/sources.list.d/elastic-6.x.list

RUN apt-get update && \
    apt-get -y install \
               kibana \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apt/archives/*

## manage files, directories and permissions
ADD ./conf_files/entrypoint.sh /
RUN chmod +x /entrypoint.sh

## expose ports
EXPOSE 5601

## start kibana service
CMD ["/entrypoint.sh"]
