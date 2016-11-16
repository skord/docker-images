#!/bin/bash
docker-compose pull
docker-compose build
docker-compose up -d consul
echo "sleeping 5 seconds to ensure consul is initialized"
sleep 5
echo "restoring consul data"
consul-backinator restore -addr desk2.local:8500
echo "bringing up cluster"
docker-compose up -d
echo "sleeping for 15 seconds so the db's can initialize"
sleep 15
docker-compose run --rm mrm bootstrap --hosts=mariadb1,mariadb2,mariadb3,mariadb4,mariadb5 --user=root:rootpassword --rpluser=repl:pass --verbose
echo "sleeping 5 to give maxscale a moment to find the topology"
docker-compose run --rm app rails db:migrate
echo "Seeding app, may take a moment"
docker-compose run --rm app rails db:seed
echo "precompiling rails assets, again, takes a moment"
docker exec -it mrmcompose_app_1 rails assets:precompile
docker-compose restart app
