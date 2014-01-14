#!/bin/bash
# Set up ownCloud dev environment for Koding.com
# Jan-Christoph Borchardt, http://jancborchardt.net
#
# One-liner to run from your terminal:
# wget https://raw.github.com/jancborchardt/owncloud-scripts/master/owncloud-koding.sh; sh owncloud-koding.sh


# Change this to "git@github.com:" if you are a core developer
GITPREFIX="https://github.com/"

# Change this path if you want to install ownCloud somewhere else
INSTALLFOLDER=$HOME/Web/

echo
echo "This script sets up a development environment for ownCloud."
echo "You’ll get the latest version from https://github.com/owncloud to play around with."
echo
echo
echo
echo "Installing dependencies ..."
sudo apt-get install php-xml-parser php5-intl sqlite php5-sqlite curl php5-curl
echo
echo
echo
echo "Downloading ownCloud core ..."
cd $INSTALLFOLDER
git clone ${GITPREFIX}owncloud/core.git owncloud
cd owncloud
echo
echo
echo
echo "Setting up 3rdparty ..."
git submodule init
git submodule update
echo
echo
echo
echo "Setting permissions ..."
mkdir data
sudo chown -R www-data:www-data data
# Keep user permissions for apps and config so you can still develop on them
sudo chown -R www-data:$USER config
sudo chown -R www-data:$USER apps
echo
echo
echo
echo "Enabling .htaccess ..."
sudo a2enmod rewrite
sudo service apache2 restart
echo
echo
echo
echo "All set up!"
echo "To finish the installation, go to http://$USER.kd.io/owncloud"
echo
