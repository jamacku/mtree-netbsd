#!/bin/bash

apt update
apt -y install wget vim

cd /home

# libmd0
wget https://launchpad.net/ubuntu/+archive/primary/+files/libmd0_1.0.1-1_amd64.deb
wget https://launchpad.net/ubuntu/+archive/primary/+files/libmd0-dbgsym_1.0.1-1_amd64.ddeb
wget https://launchpad.net/ubuntu/+archive/primary/+files/libmd-dev_1.0.1-1_amd64.deb

dpkg -i ./libmd0_1.0.1-1_amd64.deb ./libmd0-dbgsym_1.0.1-1_amd64.ddeb ./libmd-dev_1.0.1-1_amd64.deb

# libc6
# wget https://launchpad.net/ubuntu/+archive/primary/+files/libc6-dbg_2.28-0ubuntu1_amd64.deb
# wget https://launchpad.net/ubuntu/+archive/primary/+files/libc6-amd64-dbgsym_2.28-0ubuntu1_i386.ddeb
# wget https://launchpad.net/ubuntu/+archive/primary/+files/libc6-dev_2.28-0ubuntu1_amd64.deb

# mtree-netbsd
wget https://launchpad.net/ubuntu/+archive/primary/+files/mtree-netbsd_20180822-4_amd64.deb
wget https://launchpad.net/ubuntu/+archive/primary/+files/mtree-netbsd-dbgsym_20180822-4_amd64.ddeb

dpkg -i ./mtree-netbsd_20180822-4_amd64.deb ./mtree-netbsd-dbgsym_20180822-4_amd64.ddeb


