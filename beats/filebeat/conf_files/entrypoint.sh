#!/bin/bash

set -m
set -e

LOGSTASH_IPADDR=${LOGSTASH_IPADDR:-}

function config_filebeat {
    echo "${LOGSTASH_IPADDR}  logstash >> /etc/hosts"
}

function run_filebeat {
    /usr/share/filebeat/bin/filebeat -c /etc/filebeat/filebeat.yml
}

config_filebeat
run_filebeat
