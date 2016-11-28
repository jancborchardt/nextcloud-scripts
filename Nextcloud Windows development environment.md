Set up developer environment on Windows:
- Install VirtualBox
- Download Ubuntu Desktop (Server if your laptop is slower)
- Set up a virtual machine
	- standard settings
	- choose the Ubuntu file you downloaded as image
	- at the »Erase disk and install Ubuntu« it’s safe to do it because the virtual machine does not have access to your system :)
	- at a choose »LAMP server« (enable with spacebar) at the »packages to install« step
	- Install the guest additions: sudo apt-get install virtualbox-guest-dkms (http://en.ig.ma/notebook/2012/virtualbox-guest-additions-on-ubuntu-server)
- For that virtual machine, change the »network attached to« from X to Host-only: https://www.youtube.com/watch?v=1DtLEmqaOxw
- Clone Nextcloud on the local Windows host
- In VirtualBox, go to Settings -> Shared Folders and add that folder http://www.howtogeek.com/187703/how-to-access-folders-on-your-host-machine-from-an-ubuntu-virtual-machine-in-virtualbox/
	- as manual mount
	sudo mount -t vboxsf -o uid=$UID,gid=$(id -g) nextcloud /var/www/html/nextcloud (DO ON STARTUP!) (http://www.htpcbeginner.com/mount-virtualbox-shared-folder-on-ubuntu-linux/)

- create a folder »nextcloud-data« in /var/www: mkdir /var/www/nextcloud-data
- give the web server user permission: chown www-data:www-data nextcloud-data
- Install missing packages: sudo apt-get install php7.0-curl php7.0-gd php7.0-mbstring php7.0-sqlite3 php7.0-xml php7.0-zip

- add "192.168.56.101 nextcloud.dev" to hosts file https://askubuntu.com/questions/52147/how-can-i-access-apache-on-virtualbox-guest-from-host

- GO TO nextcloud.dev/nextcloud (or hosts file change)
	- choose username & password
	- change data folder to /var/www/nextcloud-data

HTTPS!?
