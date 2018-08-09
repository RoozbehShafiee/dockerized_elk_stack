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
#
# # the "ffi-rzmq-core" gem is very picky about where it looks for libzmq.so
# RUN mkdir -p /usr/local/lib \
# 	  && ln -s /usr/lib/*/libzmq.so.3 /usr/local/lib/libzmq.so

## grab gosu for easy step-down from root
# RUN set -x \
#   	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
#   	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
#   	&& export GNUPGHOME="$(mktemp -d)" \
#   	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
#   	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
#   	&& rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc \
#   	&& chmod +x /usr/local/bin/gosu \
#   	&& gosu nobody true

## generate ssl keys
RUN mkdir /etc/logstash/ssl \
    && openssl req -subj /CN=elk-stack -x509 -days 3650 \
    -batch -nodes -newkey rsa:4096 -keyout \
    /etc/logstash/ssl/logstash.key -out /etc/logstash/ssl/logstash.crt

## manage files, directories and permissions
ADD ./conf_files/filebeat-input.conf /etc/logstash/conf.d/filebeat-input.conf
ADD ./conf_files/syslog-filter.conf /etc/logstash/conf.d/syslog-filter.conf
ADD ./conf_files/output-elasticsearch.conf /etc/logstash/conf.d/output-elasticsearch.conf
ADD ./conf_files/entrypoint.sh /
RUN chmod +x /entrypoint.sh


# RUN set -ex; \
#   	if [ -f "$LS_SETTINGS_DIR/logstash.yml" ]; then \
#   		sed -ri 's!^path\.config:!#&!g' "$LS_SETTINGS_DIR/logstash.yml"; \
#   	fi; \
#     # if the "log4j2.properties" file exists (logstash 5.x), let's empty it out so we get the default: "logging only errors to the console"
#     if [ -f "$LS_SETTINGS_DIR/log4j2.properties" ]; then \
#     	cp "$LS_SETTINGS_DIR/log4j2.properties" "$LS_SETTINGS_DIR/log4j2.properties.dist"; \
#     	truncate --size=0 "$LS_SETTINGS_DIR/log4j2.properties"; \
#     fi
#
# ## run Logstash service
# ENTRYPOINT ["/entrypoint.sh"]
# CMD ["-e", ""]
CMD ["/usr/share/logstash/bin/logstash"]
