#!/bin/bash
# Set up ownCloud dev environment for Koding.com
# "sh owncloud-koding.sh" in your home folder
# Jan-Christoph Borchardt, http://jancborchardt.net

# Change this to "git@github.com:" if you are a core developer
GITPREFIX="https://github.com/"

# Change this path if you want to install ownCloud somewhere else
INSTALLFOLDER=$HOME/Web/

echo
echo "Installing dependencies ..."
sudo apt-get install php-xml-parser php5-intl sqlite php5-sqlite curl php5-curl

echo "Cloning core ..."
cd $INSTALLFOLDER
git clone ${GITPREFIX}owncloud/core.git owncloud-dev
cd owncloud
echo

echo "Setting up 3rdparty ..."
git submodule init
git submodule update
echo

echo "Setting permissions ..."
mkdir data
sudo chown -R www-data:www-data data
sudo chown -R :www-data config
# Keep user permissions for apps and config.sample.php so you can still develop on them
sudo chown user config/config.sample.php
sudo chown -R :www-data apps

echo "Enabling .htaccess ..."
sudo a2enmod rewrite
sudo service apache2 restart

echo
echo "All set up!"
echo "Now go to http://$USER.kd.io/owncloud to finish the installation"
echo
