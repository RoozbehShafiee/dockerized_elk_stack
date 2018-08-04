#!/bin/bash

function config_nginx {
    set -e
    SERVER_NAME=${SERVER_NAME:-}
    KIBANA_URL=${KIBANA_URL:-}
    KIBANA_PORT=${KIBANA_PORT:-}
    sed -i "s|server-name|${SERVER_NAME}|g" /etc/nginx/sites-available/elk.conf
    sed -i "s|kibana-url:kibana-port|${KIBANA_URL}:${KIBANA_PORT}|g" /etc/nginx/sites-available/elk.conf
}

function run_nginx {
    /usr/sbin/nginx -g 'daemon off;'
}

config_nginx
run_nginx
