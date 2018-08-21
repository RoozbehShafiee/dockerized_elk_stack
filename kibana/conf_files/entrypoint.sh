#!/bin/bash

set -m
set -e

HOST=${HOST:-}
PORT=${PORT:-}
ES_URL=${ES_HOST:-}

function config_kibana {
    sed -i "s|#server.host: \"localhost\"|server.host: \"${HOST}\"|g" /etc/kibana/kibana.yml
    sed -i "s|#server.port: 5601|server.port: ${PORT}|g" /etc/kibana/kibana.yml
    sed -i "s|#elasticsearch.url: \"http://localhost:9200\"|elasticsearch.url: \"http://${ES_HOST}:9200\"|g" /etc/kibana/kibana.yml
}

function run_kibana {
    /usr/share/kibana/bin/kibana
}

config_kibana
run_kibana
