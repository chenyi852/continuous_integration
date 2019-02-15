#!/bin/bash

set -xe

#Start with a fresh disk mounted at $FULL_RAWDIR
FULL_RAWDIR=~/win/centos7
CENTOS_RPM=http://vault.centos.org/7.4.1708/os/x86_64/Packages/centos-release-7-4.1708.el7.centos.x86_64.rpm

wget http://vault.centos.org/RPM-GPG-KEY-CentOS-7
mkdir -p $FULL_RAWDIR/var/lib/rpm
sudo rpm --rebuilddb --root=$FULL_RAWDIR
sudo rpm --root=$FULL_RAWDIR --import RPM-GPG-KEY-CentOS-7
wget $CENTOS_RPM
sudo rpm -i --root=$FULL_RAWDIR --nodeps centos-release-7-4.*.rpm
sudo yum --installroot=$FULL_RAWDIR -y clean all
sudo yum --installroot=$FULL_RAWDIR -y update
sudo yum --installroot=$FULL_RAWDIR install -y rpm-build yum openssh-server openssh-clients make cmake
sudo yum --installroot=$FULL_RAWDIR install -y sudo ca-certificates kernel-devel openssh grub2 bios-grub dracut util-linux kmod lvm2 dosfstools
sudo yum --installroot=$FULL_RAWDIR install -y gcc texinfo-tex flex zip libgcc.i386 glibc-devel.i386 gcc-c++
sudo yum --installroot=$FULL_RAWDIR install -y vim git sqlite wget openssh-askpass
sudo yum --installroot=$FULL_RAWDIR install -y pcre-devel bison flex ncurses-devel

sudo chroot $FULL_RAWDIR yum -y install automake
