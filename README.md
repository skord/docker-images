# Docker images
This repo contains  docker-compose and Dockerfiles for working with MariaDB MaxScale.

## MaxScale Docker Image
In the ```maxscale``` directory there are two sub-folders:
* ```develop```: This will build an image with any target git ref as defined by ```--build-arg VERSION=git_ref```, where you'd replace ```git_ref``` with the target git ref of the version you'd like to build. Currently only tested with MaxScale versions greater than 2.
* ```latest```: Builds the latest version of MaxScale. The version and package number are defined in the Dockerfile.

There are Rake tasks that can build these for you if you choose to use them. 
* ```rake build:maxscale:latest``` will build the latest version of MaxScale, the version information is held in ```config.yml```. 
* ```rake build:maxscale:git VERSION=git_ref``` will build an image for a given ```git_ref```.

The images vary from the default by exposing ```/tmp/maxadmin``` as a volume with the intent of being the home of the maxadmin socket. This is done for the reason of being able to access the maxadmin socket from other containers with a ```volumes_from``` directive as supported in compose template versions 1 and 2. 

A .maxadmin file is placed in the root directory of each image with the contents: ```socket=/tmp/maxadmin/maxadmin.sock```. This enables the root user to run the maxadmin command via ```docker exec``` without having to specify the socket location in the command. If you need to change the location of the maxadmin socket, make sure to change this file as well. 

You will most certainly need to override the contents of ```/etc/maxadmin.cnf``` in order for this image to be useful. It's recommended to do this as a volume mount at run time or to keep a volume with the config in it on your machine.

## Docker Compose Maxscale Examples

In the ```compose-examples``` directory you will find the following:

### mrm-async

This compose setup will create three instances of mariadb, three mariadb replication-manager agents, a mariadb replication-manager monitor, and a MaxScale server.

The MaxScale instance will have the following ports mapped:
* 13306: Read-Write splitter listener for servers 1, 2 and 3.
* 13307: Read-Only listener for server 3.
* 8003:  Maxinfo listener. (HTTP)
* 9003:  Maxinfo listneer. (MySQLClient protocol)

To get started with this setup:
1. ```cd compose-examples/mrm-async```
2. ```docker-compose up -d```
3. Wait until the health of the mariadb containers is healthy. You can check this by running ```docker ps |grep mariadb```. In column that has the uptime, you should see a status of "healthy". If the containers are not ready for operation, they will have a status of "starting" -- it can take a few minutes for them to get to "healthy".
4. Assuming your container is running on your local machine, go to http://localhost:10001 and click the **Bootstrap** button. 

After the initial setup is complete, you can connect to the listeners with the login and password root/changeme.

### galera-garbd

This will bring up two MariaDB servers with Galera replication, one instance of Galera Arbitrator (garbd), and one instance of MaxScale.

The MaxScale instance will have the following ports mapped:
* 13306: Read-Write splitter listener for servers 1 and 2.
* 8003:  Maxinfo listener. (HTTP)
* 9003:  Maxinfo listneer. (MySQLClient protocol)

To get started, just run ```docker-compose up -d``` in the directory. The credentials to connect to MaxScale are root/changeme.

### galera-three-node

