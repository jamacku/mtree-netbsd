#!/bin/bash

apt update
apt -y install wget

cd /home
# wget for libmd0
#wget 

wget https://launchpad.net/ubuntu/+archive/primary/+files/mtree-netbsd_20180822-4_amd64.deb && wget https://launchpad.net/ubuntu/+archive/primary/+files/mtree-netbsd-dbgsym_20180822-4_amd64.ddeb
dpkg -i ./mtree-netbsd_20180822-4_amd64.deb ./mtree-netbsd-dbgsym_20180822-4_amd64.ddeb


