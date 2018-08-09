#!/bin/bash

function config_kibana {
    set -e
    HOST=${HOST:-}
    PORT=${PORT:-}
    ES_URL=${ES_URL:-}
    sed -i "s|#server.host: \"localhost\"|server.host: \"${HOST}\"|g" /etc/kibana/kibana.yml
    sed -i "s|#server.port: 5601|server.port: ${PORT}|g" /etc/kibana/kibana.yml
    sed -i "s|#elasticsearch.url: \"http://localhost:9200\"|elasticsearch.url: \"http://${ES_URL}:9200\"|g" /etc/kibana/kibana.yml
}

function run_kibana {
    /usr/share/kibana/bin/kibana
}

config_kibana
run_kibana
