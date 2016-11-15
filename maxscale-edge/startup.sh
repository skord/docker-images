#!/bin/bash
set +x

if [ -z "$MAXSCALE_CONSUL_ADDR" ]
then
  echo "Missing MAXSCALE_CONSUL_ADDR environmental variable"
  exit -1
fi



set -eo pipefail
echo "[maxscale-confd] starting container."



echo "[maxscale-confd] Initial Maxscale config created. Starting Consul Watcher"

exec consul-template -consul $MAXSCALE_CONSUL_ADDR -template "/etc/consul-template/templates/maxscale.tmpl:/etc/maxscale.cnf:/restart_maxscale.sh"
