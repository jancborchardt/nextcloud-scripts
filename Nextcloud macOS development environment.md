# Nextcloud development environment on macOS


## Install dependencies

If you are running macOS 10.13 (High Sierra) or later, all dependencies are pre-installed.

For older versions:

- Install php7 and sqlite via Homebrew
- Install the php7 extensions too


## Get the Nextcloud code

- Install Github Desktop: https://desktop.github.com/ (If you like to do it manually or via the command line, use Git for Windows instead: https://git-for-windows.github.io/)
- In Github Desktop, clone the Nextcloud server repository to Windows https://github.com/nextcloud/server


## Finish installation

- Open a Terminal and in the `server` folder on your computer, run the command `php -S localhost:8080`
- In your browser, go to http://localhost:8080
	- You should see the installation screen of Nextcloud, asking for admin username and password
	- So choose an admin username & password
	- Expand the change data folder to `/var/www/nextcloud-data`

:tada:

Now do your changes and use Github Desktop to push them! Every time you want to develop on Nextcloud, you just need to run `php -S localhost:8080`. :)
