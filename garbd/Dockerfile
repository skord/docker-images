FROM ubuntu:xenial
MAINTAINER Mike Danko <michael.danko@mariadb.com>
RUN apt-get update
RUN apt-get -y install galera-arbitrator-3
ADD start.sh /start.sh
RUN chmod +x /start.sh
EXPOSE 4567
CMD ["/start.sh"]
