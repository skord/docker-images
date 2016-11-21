FROM centos:7
ENV MAXSCALE_PACKAGE_VERSION=2.0.1-2
RUN yum install -y https://downloads.mariadb.com/MaxScale/latest/rhel/7/x86_64/maxscale-${MAXSCALE_PACKAGE_VERSION}.rhel.7.x86_64.rpm
ADD startup.sh /
RUN chmod +x startup.sh
CMD ["/startup.sh"]
