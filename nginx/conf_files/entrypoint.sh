#!/bin/bash

set -m
set -e

KIBANA_URL=${KIBANA_URL:-}
KIBANA_PORT=${KIBANA_PORT:-}
ACCESS_USER=${ACCESS_USER:-}
ACCESS_PASSWORD=${ACCESS_PASSWORD:-}

function set_credentials {
    echo "${ACCESS_USER}:`openssl passwd -apr1 ${ACCESS_PASSWORD}`" | tee -a /etc/nginx/htpasswd.kibana
}

function vhost_kibana {
      sed -i "s|kibana-url:kibana-port|${KIBANA_URL}:${KIBANA_PORT}|g" /etc/nginx/sites-available/kibana
      ln -sf /etc/nginx/sites-available/kibana /etc/nginx/sites-enabled/kibana
}

function run_nginx {
    /usr/sbin/nginx -g 'daemon off;'
}

set_credentials
vhost_kibana
run_nginx
