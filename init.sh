#!/bin/sh

WAIT=200

echo "initialize the containers ..."
docker-compose down
docker-compose up -d

echo "wait $WAIT seconds for kibana comes up ..."
sleep $WAIT

echo "load dashboard configuration ..."
curl -X POST -H "Content-Type: application/json" -H "kbn-version: 7.1.0" http://127.0.0.1:5601/api/kibana/dashboards/import -d @./dashboard.json




