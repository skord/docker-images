# Consul, MariaDB, MariaDB Replication Manager, MaxScale, MaxPanel Stack

Prerequisites: A local install of consul-backinator.

### Simple Explanation

You can bring up the entire stack by running bootstrap.sh.

### Detailed Explanation

bootstrap.sh brings up a full application stack for an example application. It does so by doing the following:

* Pulls docker images for: consul, maxbook (the example app), maxpanel (gui for maxscale), prometheus exporters, and MariaDB Replication Manager.
* Builds docker images for: MariaDB (Alpine flavor, Consul aware), MaxScale (Develop branch, Consul aware)
* Brings up a Consul container
* Restores a data structure to the Consul container that describes the maxscale config and has some bootstrap SQL for the databases.
* Starts all the appropriate other containers that were pulled or built.
* Bootstraps the cluster with MariaDB Replication Manager.
* Running DB Migrations from the Rails App container (maxbook)
* Seeds the Rails app's DB from the Rails app container.
* Precompiles the Rails app's static assets.
* Restarts the Rails app so it can serve said static assets.

### What you get when it's done:

* Consul With UI: http://localhost:8500
* MaxBook: http://localhost:3000 (login/pass admin@mariadb.com/Welcome1)
* MaxPanel: http://localhost:18080
* MaxScale with Read/Write split on port 13306, Read Only on 13307, MaxInfo JSON on 8003, MaxInfo TCP on 9003.
* MaxScale Prometheus Exporter: http://localhost:9195
* MariaDB Replication Manager: http://localhost:10001
