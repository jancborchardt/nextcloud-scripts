#!/bin/bash
# Set up ownCloud core and apps from latest git master
# Hopefully git submodules will supersede this eventually
# Jan-Christoph Borchardt, http://jancborchardt.net

# Change this to git://github.com/ if you’re not a core developer
GITPREFIX="git@github.com:"

# Change this path if you want to install ownCloud somewhere else
INSTALLFOLDER=$HOME

echo
echo "Installing dependencies ..."
sudo apt-get install apache2 php5 php5-gd php-xml-parser php5-intl php5-sqlite php5-mysql php5-pgsql curl libcurl3 php5-curl

echo "Setting up core ..."
cd $INSTALLFOLDER
git clone ${GITPREFIX}owncloud/core.git owncloud
cd owncloud
echo

echo "Setting up 3rdparty ..."
git clone ${GITPREFIX}owncloud/3rdparty.git
echo

echo "Setting up apps ..."
git clone ${GITPREFIX}owncloud/apps.git apps2
sudo ln -s $HOME/owncloud/apps2/* $HOME/owncloud/apps/
echo

cd apps
for APP in appframework bookmarks calendar chat contacts documents maps music news notes tasks videos
do
  echo "Setting up $APP ..."
  git clone ${GITPREFIX}owncloud/$APP.git
  echo
done
cd ..

echo "Setting permissions ..."
mkdir data
sudo chown -R www-data:www-data data
sudo chown -R :www-data config
# Keep user permissions for apps and config.sample.php so you can still develop on them
sudo chown user config/config.sample.php
sudo chown -R :www-data apps

echo "Symlinking to /var/www ..."
sudo mkdir /var/www
sudo ln -s $INSTALLFOLDER/owncloud /var/www/

echo "Enabling .htaccess ..."
sudo a2enmod rewrite

echo "Starting server ..."
sudo service apache2 restart
sudo systemctl restart httpd.service

echo
echo "All set up!"
echo "Now go to http://localhost/owncloud to finish the installation"
echo
