#!/bin/bash
# Set up Nextcloud server & apps from latest git master
# Perfect for local development environment
# Jan-Christoph Borchardt, http://jancborchardt.net

# Change this to git://github.com/ if you’re not a core developer
GITPREFIX="git@github.com:"

# Change this path if you want to install Nextcloud somewhere else
INSTALLFOLDER=$HOME/Projects/Nextcloud

echo
echo "Installing dependencies ..."
# TODO fix the package names for zypper
#sudo zypper install -y git apache2 sqlite3 libapache2-mod-php7.0 php7.0-gd php7.0-json php7.0-sqlite3 php7.0-curl php7.0-mbstring php7.0-intl php7.0-mcrypt php-imagick php7.0-xml php7.0-zip composer

echo "Setting up server ..."
cd $INSTALLFOLDER
git clone ${GITPREFIX}nextcloud/server.git nextcloud
cd nextcloud
echo

echo "Setting up 3rdparty ..."
git submodule update --init
echo

cd apps
for APP in activity bookmarks calendar circles contacts deck files_filter files_pdfviewer files_texteditor files_videoplayer firstrunwizard gallery jsxc.nextcloud logreader mail maps news nextcloud_announcements notes notifications password_policy richdocuments serverinfo socialsharing spreed survey_client tasks user_external end_to_end_encryption
do
  echo "Setting up $APP ..."
  git clone ${GITPREFIX}nextcloud/$APP.git
  echo
done
cd ..

echo "Setting permissions ..."
mkdir data
sudo chown wwwrun:www data
sudo chown :www config/
sudo chmod 775 config/
sudo chown :www apps/
sudo chmod 775 apps/

echo "Symlinking to /srv/www/htdocs/ ..."
sudo ln -s $INSTALLFOLDER/nextcloud /srv/www/htdocs/

echo "Settings from .htaccess ..."
sudo a2enmod rewrite
sudo a2enmod headers

echo "Starting server ..."
sudo apache2ctl restart

echo
echo "All set up!"
echo "Now go to http://localhost/nextcloud to finish the installation"
echo
