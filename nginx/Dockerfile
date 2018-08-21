FROM ubuntu:18.04

## label and credits
LABEL image="Dockerized ELK Stack - NGINX reverse proxy Docker Image" \
      maintainer="Roozbeh Shafiee, me@roozbeh.cloud" \
      version="1.0.0-production" \
      released="August 4th, 2018" \
      reference="https://roozbeh.cloud, https://github.com/RoozbehShafiee"

## environment variables
ENV BRANCH=stable \
    HOME=/root \
    DEBIAN_FRONTEND=noninteractive \
    DATA_DIR=/data

## manage packages and repositories
RUN apt-get update \
    && apt-get -y dist-upgrade \
    && apt-get install -y software-properties-common \
    && add-apt-repository ppa:nginx/${BRANCH} \
    && apt-get update \
    && apt-get -y install \
                  nginx \
                  apache2-utils \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apt/archives/*

## manage files, directories and permissions
ADD ./conf_files/nginx.conf /etc/nginx/nginx.conf
ADD ./conf_files/sysctl.conf /etc/sysctl.d/10-ubuntu-nginx.conf
ADD ./conf_files/80-default /etc/nginx/sites-available/80-default
ADD ./conf_files/443-default /etc/nginx/sites-available/443-default
ADD ./conf_files/entrypoint.sh /
RUN chmod +x /entrypoint.sh
RUN rm -f /etc/nginx/sites-available/default \
    && rm -f /etc/nginx/sites-enabled/default

## forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

## expose ports
EXPOSE 80
EXPOSE 443

STOPSIGNAL SIGTERM

## run NGINX
CMD ["/entrypoint.sh"]
