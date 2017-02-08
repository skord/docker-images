FROM centos:centos7
RUN yum -y install epel-release
RUN yum -y install git gcc gcc-c++ ncurses-devel bison flex glibc-devel cmake libgcc perl \
    make libtool openssl-devel libaio libaio-devel librabbitmq-devel \
    libcurl-devel pcre-devel tcl tcl-devel systemtap-sdt-devel libuuid libuuid-devel openssl \
    lua-devel doxygen librabbitmq-devel sqlite-devel rpm-build ; yum clean all
RUN cp /usr/share/cmake/Modules/FindLua51.cmake /usr/share/cmake/Modules/FindLua.cmake
COPY build.sh /root/build.sh
WORKDIR /root
RUN git clone https://github.com/mariadb-corporation/MaxScale
WORKDIR /root/MaxScale
ARG VERSION
RUN git checkout ${VERSION}
WORKDIR /root
RUN chmod +x /root/build.sh && /root/build.sh
WORKDIR /
VOLUME /tmp/maxadmin
COPY maxscale.cnf /etc/maxscale.cnf
COPY maxadminfile /root/.maxadmin
CMD ["maxscale","-f","/etc/maxscale.cnf","-l","stdout","-d"]
