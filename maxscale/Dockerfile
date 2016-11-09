FROM centos:7
RUN yum install -y https://downloads.mariadb.com/MaxScale/latest/rhel/7/x86_64/maxscale-2.0.1-2.rhel.7.x86_64.rpm
RUN yum install -y unzip
ADD https://releases.hashicorp.com/consul-template/0.16.0/consul-template_0.16.0_linux_amd64.zip /tmp/consul-template.zip
RUN unzip /tmp/consul-template.zip
RUN mv /consul-template /usr/bin/consul-template \
    && chmod +x /usr/bin/consul-template
ADD templates /etc/consul-template/templates
RUN rm -f /etc/maxscale.cnf
ADD startup.sh restart_maxscale.sh /
RUN chmod +x startup.sh restart_maxscale.sh
CMD ["/startup.sh"]
