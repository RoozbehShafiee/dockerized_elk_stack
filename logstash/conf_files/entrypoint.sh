#!/bin/bash

set -m
set -e

ES_HOST=${ES_HOST:-}
ES_PORT=${ES_PORT:-}
SUPPORT_SSL=${SUPPORT_SSL:-}

function support_ssl {
  if [ $SUPPORT_SSL = "yes" ]; then
      sed -i "s|SUPPORT_SSL|true|g" /etc/logstash/conf.d/filebeat-input.conf
  else
      sed -i "s|SUPPORT_SSL|false|g" /etc/logstash/conf.d/filebeat-input.conf
      sed -i '/ssl_certificate/d' /etc/logstash/conf.d/filebeat-input.conf
      sed -i '/ssl_key/d' /etc/logstash/conf.d/filebeat-input.conf
  fi
}

function config_logstash {
    sed -i "s|ES_HOST|${ES_HOST}|g" /etc/logstash/conf.d/output-elasticsearch.conf
		sed -i "s|ES_PORT|${ES_PORT}|g" /etc/logstash/conf.d/output-elasticsearch.conf
}

function run_logstash {
    /usr/share/logstash/bin/logstash
}

support_ssl
config_logstash
run_logstash
