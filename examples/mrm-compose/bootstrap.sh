#!/bin/bash
docker-compose up -d consul
consul-backup -i localhost:8500 --restore consul.backup
docker-compose up -d
echo "sleeping for 15 seconds so the db's can initialize"
sleep 15
docker-compose run --rm mrm bootstrap --hosts=mariadb1,mariadb2,mariadb3,mariadb4,mariadb5 --user=root:rootpassword --rpluser=repl:pass --verbose
echo "sleeping 5 to give maxscale a moment to find the topology"
docker-compose run --rm app rails db:migrate
echo "Seeding app, may take a moment"
docker-compose run --rm app rails db:seed
