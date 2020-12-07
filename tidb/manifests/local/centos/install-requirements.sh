#!/bin/bash

## install common packages
yum install -y wget curl sudo make file perl gcc gcc-c++ vim-common unzip rsyslog iptables ncurses-devel iproute logrotate

## install start-stop-daemon
curl -sL  https://mirrors.tuna.tsinghua.edu.cn/debian/pool/main/d/dpkg/dpkg_1.17.27.tar.xz | tar -xJ
cd dpkg-1.17.27/
./configure
make
cp utils/start-stop-daemon /usr/bin/start-stop-daemon
cd ..
rm -rf dpkg-1.17.27/
