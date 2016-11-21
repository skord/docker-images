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
RUN mkdir -p /root/build /var/run/maxscale /var/cache/maxscale
WORKDIR /root/build
RUN cmake ../MaxScale -DBUILD_TESTS=N -DWITH_SCRIPTS=N -DMAKE_INSTALL_PREFIX=/usr
RUN make && make install
WORKDIR /
ADD maxscale.sh /
RUN chmod +x maxscale.sh
RUN rm -rf /root/build /root/MaxScale
COPY maxscale.cnf /etc/maxscale.cnf
COPY maxadminfile /root/.maxadmin
RUN mkdir -p /tmp/maxadmin
VOLUME /tmp/maxadmin
CMD ["/maxscale.sh"]
