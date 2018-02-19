# Nextcloud development environment on macOS

1. Install php7 and sqlite via Homebrew
2. Install the php7 extensions too
3. Run `php -S localhost:8000`


## Get the Nextcloud code

- Install Github Desktop: https://desktop.github.com/ (If you like to do it manually or via the command line, use Git for Windows instead: https://git-for-windows.github.io/)
- In Github Desktop, clone the Nextcloud server repository to Windows https://github.com/nextcloud/server


## Finish installation

- In your browser, go to nextcloud.dev/nextcloud
	- You should see the installation screen of Nextcloud, asking for admin username and password
	- So choose an admin username & password
	- Expand the change data folder to `/var/www/nextcloud-data`

:tada:

Now do your changes and use Github Desktop to push them! Every time you want to develop on Nextcloud, you just need to start your VM. :)
