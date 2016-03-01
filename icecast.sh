#!/bin/bash
# -*- ENCODING: UTF-8 -*-
# Miguel Salcedo <imiguelsalcedo at hotmail dot com>

clear
echo "+=====================================================================+"
echo "|                         IcecastKH-autoinstaller                     |"
echo "+=====================================================================+"
echo "|                          System Update                              |"
echo "|                Installation of development tools                    |"
echo "|                  Compilation and Installation                       |"
echo "|                            Settings                                 |"
echo "+=====================================================================+"

# Update
echo -e "\n --------In five seconds the system upgrade will start--------\n"
sleep 5

yum -y update
echo -e "System updated"
sleep 2

echo -e "\n --------Installing necessary software--------\n"
sleep 3
yum -y install wget
yum -y install nano
yum -y groupinstall "Development Tools"
yum install -y curl-devel libtheora-devel libvorbis-devel libxslt-devel speex-devel libxslt
rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt
cd /home
wget http://packages.sw.be/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
mkdir -p /usr/src/icecast
cd /usr/src/icecast
wget https://github.com/karlheyes/icecast-kh/archive/master.zip 
unzip master.zip
cd icecast-kh-master/

echo -e "\n --------Compile and Install--------\n"
sleep 3
./configure
make
make install

ls /usr/local/bin/

echo -e "\n --------Settings--------\n"
sleep 3
groupadd -g 200 icecast
useradd -d /var/log/icecast -m -g icecast -s /bin/bash -u 200 icecast

mkdir -p /var/run/icecast
chown -R icecast:icecast /var/run/icecast


echo -e "\n --------icecast.xml--------\n"
cp /usr/src/icecast/icecast-kh-master/examples/icecast.xml /usr/local/etc/icecast.bak.xml
mv /IcecastKH-autoinstaller/icecast.xml /usr/local/etc/
nano icecast.xml

echo -e "Start server= /usr/local/bin/icecast -c /usr/local/etc/icecast.xml -b"
