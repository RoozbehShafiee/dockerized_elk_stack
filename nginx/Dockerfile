## Containerized ELK Stack based on ubuntu 16.04

FROM ubuntu:16.04

LABEL image="A Docker image for NGINX reverse proxy" \
      maintainer="Roozbeh Shafiee, r.shafiee@celonis.com" \
      division="DevOps" \
      version="1.0.0-production_0" \
      released="November 27, 2017"

## manage packages and repositories
RUN apt update \
    && apt install -y \
    nginx \
    apache2-utils

RUN rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apt/archives/*

## manage files, directories and permissions
ADD ./conf_files/nginx.conf /etc/nginx/nginx.conf
ADD ./conf_files/sysctl.conf /etc/sysctl.d/10-ubuntu-nginx.conf
ADD ./conf_files/default.conf /etc/nginx/sites-available/elk.conf
ADD ./conf_files/run.sh /
RUN chmod +x /run.sh
RUN ln -s /etc/nginx/sites-available/elk.conf /etc/nginx/sites-enabled/elk.conf \
    && rm -f /etc/nginx/sites-available/default \
    && rm -f /etc/nginx/sites-enabled/default

## forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

## expose ports
EXPOSE 80
EXPOSE 443

STOPSIGNAL SIGTERM

## run NGINX
CMD ["/run.sh"]
