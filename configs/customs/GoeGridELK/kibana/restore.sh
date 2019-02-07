#!/bin/bash

cd $(dirname $0)
kibana_port=$1
[ -z "$kibana_port" ] && kibana_port=5601
curl -u elastic:changeme -k -XPOST "http://localhost:${kibana_port}/api/kibana/dashboards/import" -H 'Content-Type: application/json' -H "kbn-xsrf: true" -d @export.json
