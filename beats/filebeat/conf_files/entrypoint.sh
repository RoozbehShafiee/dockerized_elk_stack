#!/bin/bash

set -m
set -e

LOGSTASH_ENDPOINT=${LOGSTASH_ENDPOINT:-}
PORT=${PORT:-}

function config_filebeat {
    sed -i "s|logstash-endpoint|${LOGSTASH_ENDPOINT}|g" /etc/filebeat/filebeat.yml
}

function run_filebeat {
    /usr/share/filebeat/bin/filebeat -c /etc/filebeat/filebeat.yml
}

config_filebeat
run_filebeat
