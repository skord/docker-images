FROM skord/maxscale:edge
RUN rm /etc/maxscale.cnf
RUN yum install -y unzip
WORKDIR /
ADD https://releases.hashicorp.com/consul-template/0.16.0/consul-template_0.16.0_linux_amd64.zip /tmp/consul-template.zip
RUN unzip /tmp/consul-template.zip
RUN mv /consul-template /usr/bin/consul-template \
    && chmod +x /usr/bin/consul-template
ADD templates /etc/consul-template/templates
ADD startup.sh restart_maxscale.sh /
RUN chmod +x startup.sh restart_maxscale.sh
RUN rm -rf /root/build /root/MaxScale
CMD ["/startup.sh"]
