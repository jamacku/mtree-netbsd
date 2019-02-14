#!/bin/bash

apt update
apt -y install wget vim gdb dpkg-dev

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

# mtree source files
wget https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/mtree-netbsd/20180822-4/mtree-netbsd_20180822-4.diff.gz
wget https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/mtree-netbsd/20180822-4/mtree-netbsd_20180822.orig.tar.gz
wget https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/mtree-netbsd/20180822-4/mtree-netbsd_20180822-4.dsc

dpkg-source -x mtree-netbsd_20180822-4.dsc

# sudo docker container run -d -it --mount type=bind,source=/home/jamacku/Source/mtree-netbsd/docker-init.sh,target=/home/docker-init.sh --cap-add=SYS_PTRACE --security-opt seccomp=unconfined ubuntu:latest
# sudo docker exec -it <name> /bin/bash

# gdb --args mtre -c
# -> start
# -> dir /home/mtree-netbsd-20180822/
