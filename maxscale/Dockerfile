FROM centos:7
ENV MAXSCALE_VERSION=2.2.10
ENV MAXSCALE_PACKAGE_VERSION=1
RUN yum install -y https://downloads.mariadb.com/MaxScale/${MAXSCALE_VERSION}/centos/7/x86_64/maxscale-${MAXSCALE_VERSION}-${MAXSCALE_PACKAGE_VERSION}.centos.7.x86_64.rpm && yum clean all
CMD ["maxscale","-f","/etc/maxscale.cnf","-l","stdout","-d"]
