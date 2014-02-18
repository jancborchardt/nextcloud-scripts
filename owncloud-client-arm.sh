#!/bin/bash
# Install ownCloud sync client on Samsung ARM Chromebook with Ubuntu
# Based on the build instructions: http://doc.owncloud.org/desktop/1.3/building.html


# Add repository from Open Build Service
#sudo su
#echo 'deb http://download.opensuse.org/repositories/isv:ownCloud:devel/xUbuntu_12.04/ /' >> /etc/apt/sources.list.d/owncloud-client.list
#exit
#sudo apt-get update
wget http://download.opensuse.org/repositories/isv:ownCloud:devel/xUbuntu_12.04/Release.key
sudo apt-key add - < Release.key
rm Release.key


# Install dependencies
sudo apt-get install build-essential build-dep cmake qt-sdk libsqlite3-dev libneon27-dev

# Build and install mirall (adjust /home/user to your path)
mkdir mirall-build
cd mirall-build
cmake -DCMAKE_BUILD_TYPE="Debug" ../mirall
make
sudo make install
cd ..
sudo rm -r mirall-build


echo
echo 'Aaand ownCloud is installed!'
echo
