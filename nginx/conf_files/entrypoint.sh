#!/bin/bash

set -m
set -e

KIBANA_FQDN=${KIBANA_FQDN:-}
KIBANA_URL=${KIBANA_URL:-}
KIBANA_PORT=${KIBANA_PORT:-}
LOGSTASH_FQDN=${LOGSTASH_FQDN:-}
LOGSTASH_URL=${LOGSTASH_URL:-}
LOGSTASH_PORT=${LOGSTASH_PORT:-}
ACCESS_USER=${ACCESS_USER:-}
ACCESS_PASSWORD=${ACCESS_PASSWORD:-}

function set_credentials {
    echo "${ACCESS_USER}:`openssl passwd -apr1 ${ACCESS_PASSWORD}`" | tee -a /etc/nginx/htpasswd.kibana
}

function set_kibana {
      sed -i "s|FQDN|${KIBANA_FQDN}|g" /etc/nginx/sites-available/kibana
      sed -i "s|kibana-url:kibana-port|${KIBANA_URL}:${KIBANA_PORT}|g" /etc/nginx/sites-available/kibana
      ln -sf /etc/nginx/sites-available/kibana /etc/nginx/sites-enabled/kibana
      chmod 600 /etc/nginx/ssl/kibana/*
}

function set_logstash {
      sed -i "s|FQDN|${LOGSTASH_FQDN}|g" /etc/nginx/sites-available/logstash
      sed -i "s|logstash-url:logstash-port|${LOGSTASH_URL}:${LOGSTASH_PORT}|g" /etc/nginx/sites-available/logstash
      ln -sf /etc/nginx/sites-available/logstash /etc/nginx/sites-enabled/logstash
      chmod 600 /etc/nginx/ssl/logstash/*
}

function run_nginx {
    /usr/sbin/nginx -g 'daemon off;'
}

set_credentials
set_kibana
set_logstash
run_nginx
