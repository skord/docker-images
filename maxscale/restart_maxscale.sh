#!/bin/bash




set -eo pipefail

if [ -e "/var/run/maxscale/maxscale.pid" ]; then
  kill -9 $(cat /var/run/maxscale/maxscale.pid)
  rm /var/run/maxscale/maxscale.pid
fi



maxscale -f /etc/maxscale.cnf -l stdout
