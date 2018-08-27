#!/bin/bash

set -m
set -e

ES_HOST=${ES_HOST:-}
ES_PORT=${ES_PORT:-}

function config_logstash {
    sed -i "s|ES_HOST|${ES_HOST}|g" /etc/logstash/conf.d/output-elasticsearch.conf
		sed -i "s|ES_PORT|${ES_PORT}|g" /etc/logstash/conf.d/output-elasticsearch.conf
}

function run_logstash {
    /usr/share/logstash/bin/logstash --path.settings /etc/logstash/
}

config_logstash
run_logstash
