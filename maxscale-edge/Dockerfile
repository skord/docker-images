FROM centos:centos7
RUN yum -y install epel-release
RUN yum -y install git gcc gcc-c++ ncurses-devel bison flex glibc-devel cmake libgcc perl \
    make libtool openssl-devel libaio libaio-devel librabbitmq-devel \
    libcurl-devel pcre-devel tcl tcl-devel systemtap-sdt-devel libuuid libuuid-devel openssl \
    lua-devel doxygen librabbitmq-devel
RUN cp /usr/share/cmake/Modules/FindLua51.cmake /usr/share/cmake/Modules/FindLua.cmake
WORKDIR /root
RUN git clone https://github.com/mariadb-corporation/MaxScale
WORKDIR /root/MaxScale
RUN git checkout develop
WORKDIR /root
RUN mkdir -p /root/build
WORKDIR /root/build
RUN cmake ../MaxScale -DBUILD_TESTS=N -DWITH_SCRIPTS=N -DMAKE_INSTALL_PREFIX=/usr
RUN make && make install
RUN yum install -y unzip
WORKDIR /
ADD https://releases.hashicorp.com/consul-template/0.16.0/consul-template_0.16.0_linux_amd64.zip /tmp/consul-template.zip
RUN unzip /tmp/consul-template.zip
RUN mv /consul-template /usr/bin/consul-template \
    && chmod +x /usr/bin/consul-template
ADD templates /etc/consul-template/templates
ADD startup.sh restart_maxscale.sh /
RUN chmod +x startup.sh restart_maxscale.sh
CMD ["/startup.sh"]
