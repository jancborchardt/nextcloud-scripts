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

# iniparser needs to be installed manually
wget http://ndevilla.free.fr/iniparser/iniparser-3.1.tar.gz
tar xf iniparser-3.1.tar.gz
cd iniparser
make
sudo cp libiniparser* /usr/lib
sudo cp src/*.h /usr/include
cd ..
rm iniparser-3.1.tar.gz
rm -r iniparser/


# Get latest csync and mirall dev versions
git clone git://git.csync.org/users/freitag/csync.git ocsync
cd ocsync
git checkout dav
cd ..
git clone git://github.com/owncloud/mirall.git


# Build and install csync
mkdir ocsync-build
cd ocsync-build
cmake -DCMAKE_BUILD_TYPE="Debug" ../ocsync
make
sudo make install
cd ..
sudo rm -r ocsync-build


# Build and install mirall (adjust /home/user to your path)
mkdir mirall-build
cd mirall-build
cmake -DCMAKE_BUILD_TYPE="Debug" ../mirall \
      -DCSYNC_BUILD_PATH=/home/user/ocsync-build \
      -DCSYNC_INCLUDE_PATH=/home/user/ocsync/src
make
sudo make install
cd ..
sudo rm -r mirall-build


# Copy to global
sudo cp /usr/local/lib/libowncloudsync.so* /usr/lib/
sudo cp /usr/local/lib/libocsync.so* /usr/lib/


echo
echo 'Aaand ownCloud is installed!'
echo
