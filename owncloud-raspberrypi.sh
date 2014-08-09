#!/bin/bash
# Set up ownCloud on a Raspberry Pi
# Plus extras (easy access and backups)
# Making it a fully capable home server



# Some prerequisites:
# 1. Get a Raspberry Pi, including power supply, SD card and network cable
# 2. Install Raspbian on the SD card using your computer
#    http://www.raspberrypi.org/documentation/installation/installing-images/README.md
# 3. Put the SD card in your Rasperry Pi, connect it to the router or your computer using the network cable and let it start up.
# 4. Use SSH to log in to the Pi from your laptop: ssh pi@raspberrypi
#    http://www.raspberrypi.org/documentation/remote-access/ssh/unix.md



# Now run this script!
# 5. Use raspi-config to expand the filesystem and set a password
# http://www.raspberrypi.org/documentation/configuration/raspi-config.md
sudo raspi-config



# 6. Install Apache & PHP: http://www.raspberrypi.org/documentation/remote-access/web-server/apache.md
sudo apt-get install apache2 -y
sudo apt-get install php5 libapache2-mod-php5 -y

# 6.1 (optional instead of using SQLite)
# Install MySQL, set a password, and create a database
# http://www.raspberrypi.org/documentation/usage/wordpress/README.md
# sudo apt-get install mysql-server php5-mysql -y
# mysql -uroot -p
# In MySQL: create database owncloud; exit;



# 7. Download and set up ownCloud
# Install ownCloud from packages https://owncloud.org/install/#instructions-packages
sudo sh -c 'echo "deb http://download.opensuse.org/repositories/isv:/ownCloud:/community/Debian_7.0/ /" >> /etc/apt/sources.list.d/owncloud.list'
wget http://download.opensuse.org/repositories/isv:ownCloud:community/Debian_7.0/Release.key
sudo apt-key add - < Release.key
rm Release.key
sudo apt-get update
sudo apt-get install owncloud

echo 'Setting up APC for caching ...'
sudo apt-get install php-apc php5-dev -y
sudo pecl install apc
sudo sh -c 'echo "extension=apc.so" >> /etc/php5/cgi/conf.d/apc.ini'
sudo sh -c 'echo "apc.enabled=1" >> /etc/php5/cgi/conf.d/apc.ini'
sudo sh -c 'echo "apc.shm_size=30" >> /etc/php5/cgi/conf.d/apc.ini'

# TODO
# Further optimizations from http://www.instructables.com/id/Raspberry-Pi-Owncloud-dropbox-clone/?ALLSTEPS
# (Especially modifications to the php.ini, 000-default and .htaccess)

sudo a2enmod rewrite
sudo a2enmod headers
echo "Restarting server ..."
sudo service apache2 restart



# 8. Finish the ownCloud installation using the web interface
echo 'Now go to http://raspberrypi/owncloud and finish the installation'
echo "Choose an admin username and password, and you're done! :)"





# ENHANCEMENTS



# 9. Install PageKite to be able to access your Pi remotely with ease
# https://pagekite.net/wiki/Howto/GNULinux/DebianPackage/
echo deb http://pagekite.net/pk/deb/ pagekite main | sudo tee -a /etc/apt/sources.list
sudo apt-key adv --recv-keys --keyserver keys.gnupg.net AED248B1C7B2CAC3
sudo apt-get update
sudo apt-get install pagekite

# Configure the system https://pagekite.net/wiki/Howto/GNULinux/ConfigureYourSystem/
sudo nano /etc/pagekite.d/10_account.rc
sudo mv /etc/pagekite.d/80_httpd.rc.sample /etc/pagekite.d/80_httpd.rc
sudo mv /etc/pagekite.d/80_sshd.rc.sample /etc/pagekite.d/80_sshd.rc
sudo invoke-rc.d pagekite restart
# TODO set up SSH connection: https://pagekite.net/wiki/Howto/SshOverPageKite/



# 10. Set up backups
# http://www.raspberrypi.org/documentation/linux/filesystem/backup.md
# TODO


# 11. If you have an SSH key, add the public key to the Pi for easier log in
mkdir .ssh
cd .ssh
nano authorized_keys
#TODO: properly check if there is a key and copy it over
cd ..
chmod 700 .ssh/
chmod 600 .ssh/authorized_keys