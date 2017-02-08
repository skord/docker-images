#!/bin/bash
mkdir -p /root/build /var/run/maxscale /var/cache/maxscale /tmp/maxadmin
cd /root/build
cmake ../MaxScale -DBUILD_TESTS=N -DWITH_SCRIPTS=N -DCMAKE_INSTALL_PREFIX=/usr
make
make install
rm -rf /root/build /root/MaxScale
