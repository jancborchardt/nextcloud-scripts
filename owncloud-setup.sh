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

echo "Setting up apps ..."
git clone ${GITPREFIX}owncloud/apps.git apps2
# Only take the needed apps from the apps repository
ln -s $HOME/owncloud/apps2/activity $HOME/owncloud/apps/
ln -s $HOME/owncloud/apps2/files_odfviewer $HOME/owncloud/apps/
ln -s $HOME/owncloud/apps2/files_pdfviewer $HOME/owncloud/apps/
ln -s $HOME/owncloud/apps2/files_videoviewer $HOME/owncloud/apps/
ln -s $HOME/owncloud/apps2/firstrunwizard $HOME/owncloud/apps/
ln -s $HOME/owncloud/apps2/l10n $HOME/owncloud/apps/
ln -s $HOME/owncloud/apps2/search $HOME/owncloud/apps/
ln -s $HOME/owncloud/apps2/tasks $HOME/owncloud/apps/
ln -s $HOME/owncloud/apps2/updater $HOME/owncloud/apps/
echo

cd apps
for APP in appframework bookmarks calendar chat contacts documents files_texteditor gallery mail maps mozilla_sync music news notes tasks videos
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

echo "Enabling .htaccess ..."
sudo a2enmod rewrite

echo "Starting server ..."
sudo service apache2 restart
sudo systemctl restart httpd.service

echo
echo "All set up!"
echo "Now go to http://localhost/owncloud to finish the installation"
echo
