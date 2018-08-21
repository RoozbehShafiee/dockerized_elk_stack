#!/bin/bash

set -m
set -e

FQDN=${FQDN:-}
SUPPORT_SSL=${SUPPORT_SSL:-}
KIBANA_URL=${KIBANA_URL:-}
KIBANA_PORT=${KIBANA_PORT:-}
ACCESS_USER=${ACCESS_USER:-}
ACCESS_PASSWORD=${ACCESS_PASSWORD:-}

function set_credentials {
    echo "${ACCESS_USER}:`openssl passwd -apr1 ${ACCESS_PASSWORD}`" | tee -a /etc/nginx/htpasswd.kibana
}

function support_ssl {
  if [ $SUPPORT_SSL = "yes" ]; then
      sed -i "s|FQDN|${FQDN}|g" /etc/nginx/sites-available/443-default
      sed -i "s|kibana-url:kibana-port|${KIBANA_URL}:${KIBANA_PORT}|g" /etc/nginx/sites-available/443-default
      ln -sf /etc/nginx/sites-available/443-default /etc/nginx/sites-enabled/443-default
      chmod 600 /etc/nginx/ssl/*
  else
      sed -i "s|FQDN|${FQDN}|g" /etc/nginx/sites-available/80-default
      sed -i "s|kibana-url:kibana-port|${KIBANA_URL}:${KIBANA_PORT}|g" /etc/nginx/sites-available/80-default
      ln -sf /etc/nginx/sites-available/80-default /etc/nginx/sites-enabled/80-default
  fi
}

function run_nginx {
    /usr/sbin/nginx -g 'daemon off;'
}

set_credentials
support_ssl
run_nginx
