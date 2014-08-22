#!/bin/bash

RETCODE=$(fw_exists $IROOT/mono.fail)
[ ! "$RETCODE" == 0 ] || { return 1; }

RETCODE=$(fw_exists $IROOT/mono.installed)
[ ! "$RETCODE" == 0 ] || { return 0; }

sudo apt-get install -y \
             build-essential \
             autoconf \
             automake \
             libtool \
             zlib1g-dev \
             pkg-config \
             gettext

fw_get http://download.mono-project.com/sources/mono/mono-3.6.0.tar.bz2 -O mono-3.6.0.tar.bz2
fw_untar mono-3.6.0.tar.bz2

(cd mono-3.6.0                                                                                            && \
./configure --prefix=$IROOT/mono-3.6.0-install                                                            && \
make -j4                                                                                                  && \
make install                                                                                              && \ 
                                                                                                             \
echo "Installing RootCAs from Mozilla..."                                                                 && \
                                                                                                             \
(echo -e 'y\ny\ny\ny\n' | certmgr -ssl https://nuget.org || true)                                         && \
mozroots --import --sync                                                                                  && \
                                                                                                             \
(echo -e 'y\ny\ny\ny\n' | sudo $IROOT/mono-3.6.0-install/bin/certmgr -ssl -m https://nuget.org || true)   && \
sudo $IROOT/mono-3.6.0-install/bin/mozroots --import --sync --machine                                     && \
                                                                                                             \
touch $IROOT/mono.installed) || touch $IROOT/mono.fail
