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
sudo apt-get install -y git apache2 php5 php5-gd php-xml-parser php5-intl php5-sqlite php5-mysql php5-pgsql curl libcurl3 php5-curl php5-json

echo "Setting up core ..."
cd $INSTALLFOLDER
git clone ${GITPREFIX}owncloud/core.git owncloud
cd owncloud
echo

echo "Setting up 3rdparty ..."
git submodule init
git submodule update
echo

cd apps
for APP in activity bookmarks calendar chat contacts documents files_pdfviewer files_texteditor firstrunwizard gallery mail maps mozilla_sync music news notes tasks updater videos
do
  echo "Setting up $APP ..."
  git clone ${GITPREFIX}owncloud/$APP.git
  echo
done
cd ..

echo "Setting permissions ..."
mkdir data
sudo chown www-data:www-data data
sudo chown :www-data config/
sudo chmod 775 config/
sudo chown :www-data apps/
sudo chmod 775 apps/

echo "Symlinking to /var/www ..."
sudo mkdir /var/www
sudo ln -s $INSTALLFOLDER/owncloud /var/www/

echo "Settings from .htaccess ..."
sudo a2enmod rewrite
sudo a2enmod headers

echo "Starting server ..."
sudo service apache2 restart
sudo systemctl restart httpd.service

echo
echo "All set up!"
echo "Now go to http://localhost/owncloud to finish the installation"
echo
