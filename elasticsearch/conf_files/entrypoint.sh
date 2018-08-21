#!/bin/bash

set -m
set -e

HOST=${HOST:-}
PORT=${PORT:-}

function config_elasticsearch {
    sed -i "s|#network.host: 192.168.0.1|http.host: ${HOST}|g" /etc/elasticsearch/elasticsearch.yml
    sed -i "s|#http.port: 9200|http.port: ${PORT}|g" /etc/elasticsearch/elasticsearch.yml
}

function run_elasticsearch {
    su - elasticsearch -c "/usr/share/elasticsearch/bin/elasticsearch"
}

config_elasticsearch
run_elasticsearch
