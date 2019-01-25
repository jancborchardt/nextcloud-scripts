#!/bin/bash
# Set up Nextcloud server & apps from latest git master
# Perfect for local development environment
# Jan-Christoph Borchardt, http://jancborchardt.net

# Change this to git://github.com/ if you’re not a core developer
GITPREFIX="git@github.com:"

# Change this path if you want to install Nextcloud somewhere else
INSTALLPATH=$HOME

# Change this folder if you want a different name for the Nextcloud folder
INSTALLFOLDER="nextcloud"

echo
echo "Installing dependencies ..."
sudo apt-get install -y git apache2 sqlite3 libapache2-mod-php7.0 php7.0-gd php7.0-json php7.0-sqlite3 php7.0-curl php7.0-mbstring php7.0-intl php7.0-mcrypt php-imagick php7.0-xml php7.0-zip composer


echo "Setting up server ..."
cd $INSTALLPATH
git clone ${GITPREFIX}nextcloud/server.git $INSTALLFOLDER
cd $INSTALLFOLDER
echo

echo "Setting up 3rdparty ..."
git submodule update --init
echo

cd apps
for APP in activity bookmarks calendar circles contacts deck files_filter files_pdfviewer files_texteditor files_videoplayer firstrunwizard gallery jsxc.nextcloud logreader mail maps news nextcloud_announcements notes notifications password_policy richdocuments serverinfo socialsharing spreed survey_client tasks user_external
do
  echo "Setting up $APP ..."
  git clone ${GITPREFIX}nextcloud/$APP.git
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
sudo ln -s $INSTALLPATH/$INSTALLFOLDER /var/www/


echo "Creating Apache configuration ..."
# https://docs.nextcloud.com/server/latest/admin_manual/installation/source_installation.html#apache-web-server-configuration
sudo cat >/etc/apache2/sites-available/$INSTALLFOLDER.conf <<EOL
Alias /${INSTALLFOLDER} "/var/www/${INSTALLFOLDER}/"

<Directory /var/www/${INSTALLFOLDER}/>
  Options +FollowSymlinks
  AllowOverride All

 <IfModule mod_dav.c>
  Dav off
 </IfModule>

 SetEnv HOME /var/www/${INSTALLFOLDER}
 SetEnv HTTP_HOME /var/www/${INSTALLFOLDER}

</Directory>
EOL

sudo cat /etc/apache2/sites-available/$INSTALLFOLDER.conf

sudo a2ensite $INSTALLFOLDER.conf


echo "Settings from .htaccess ..."
sudo a2enmod rewrite
sudo a2enmod headers

echo "Starting server ..."
sudo service apache2 restart
sudo systemctl reload apache2
sudo systemctl restart httpd.service

echo
echo "All set up!"
echo "Now go to http://localhost/${INSTALLFOLDER} to finish the installation"
echo
