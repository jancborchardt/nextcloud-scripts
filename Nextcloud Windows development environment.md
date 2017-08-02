# Nextcloud development environment on Windows


## Set up a Virtual Machine with Ubuntu to act as the server

- Install VirtualBox: https://www.virtualbox.org/wiki/Downloads (click »Windows hosts«)
- Download Ubuntu Desktop https://www.ubuntu.com/download/desktop (Server if your laptop is slower) https://www.ubuntu.com/download/server
- Set up the virtual machine
	- Standard settings
	- Choose the Ubuntu file you downloaded as image
	- At the »Erase disk and install Ubuntu« it’s safe to do it because the virtual machine does not have access to your system :)
	- At the step of where to install additional packages, choose »LAMP server« – enable with spacebar (if you missed it, just do `sudo apt-get install lamp-server^` in the installed Ubuntu)
	- Install the guest additions to make shared folders work: `sudo apt-get install virtualbox-guest-dkms` (http://en.ig.ma/notebook/2012/virtualbox-guest-additions-on-ubuntu-server)
	- Install the additional needed packages for Nextcloud: `sudo apt-get install php7.0-curl php7.0-gd php7.0-mbstring php7.0-sqlite3 php7.0-xml php7.0-zip`
	- For that virtual machine, change the »network attached to« from NAT to Host-only so the VM is accessible by Windows: https://www.youtube.com/watch?v=1DtLEmqaOxw (This will also cut off internet access for the VM, but it’s not needed anymore) (TODO: Try the IP it gives out for bridged so it gets both?)


## Get the Nextcloud code

- Install Github Desktop: https://desktop.github.com/ (If you like to do it manually or via the command line, use Git for Windows instead: https://git-for-windows.github.io/)
- In Github Desktop, clone the Nextcloud server repository to Windows https://github.com/nextcloud/server


## Enable the VM to access the Nextcloud code folder

- In VirtualBox, go to Settings -> Shared Folders and add that Nextcloud folder http://www.howtogeek.com/187703/how-to-access-folders-on-your-host-machine-from-an-ubuntu-virtual-machine-in-virtualbox/
	- As manual mount because otherwise there are permission issues:
	`sudo -H -u username mount -t vboxsf -o uid=$UID,gid=$(id -g) nextcloud /var/www/html/nextcloud` (TODO: do on startup, and maybe for www-data directly?) (http://www.htpcbeginner.com/mount-virtualbox-shared-folder-on-ubuntu-linux/)
	- (if that doesn't work try `sudo mount -t vboxsf -o uid=$UID,gid=$(id -g) nextcloud /var/www/html/nextcloud`)
	- add this command to sudo nano /etc/rc.local before »exit 0« https://askubuntu.com/questions/294736/run-a-shell-script-as-another-user-that-has-no-password
	- create a folder »nextcloud-data« in /var/www: `mkdir /var/www/nextcloud-data`
	- give the web server user permission: `chown www-data:www-data nextcloud-data`


## (optional) Give a nice address to access the VM

- Add `192.168.56.101 nextcloud.dev` to the Windows hosts file (or whatever the IP of the virtual machine is, you can find out via the command `ifconfig` in the Ubuntu VM) https://askubuntu.com/questions/52147/how-can-i-access-apache-on-virtualbox-guest-from-host
- TODO: How to make it HTTPS so Spreed / WebRTC works?


## Finish installation

- In your browser on Windows, go to nextcloud.dev/nextcloud (or whatever you changed it to in the previous step)
	- You should see the installation screen of Nextcloud, asking for admin username and password
	- So choose an admin username & password
	- Expand the change data folder to `/var/www/nextcloud-data`

:tada:

Now do your changes and use Github Desktop to push them! Every time you want to develop on Nextcloud, you just need to start your VM. :)
