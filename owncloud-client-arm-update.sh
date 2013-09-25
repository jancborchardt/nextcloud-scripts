#!/bin/bash
# Update ownCloud sync client on Samsung ARM Chromebook with Ubuntu
# Based on the build instructions: http://doc.owncloud.org/desktop/1.3/building.html


# Get latest csync and mirall dev versions
cd ocsync
git checkout dav
git pull
cd ../mirall
git pull
cd ..


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
echo 'Aaand ownCloud is updated!'
echo