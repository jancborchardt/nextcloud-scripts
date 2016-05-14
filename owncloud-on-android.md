# ownCloud on Android

How to set up a server / development environment.

Apps you need:
- [Pocket Git](https://play.google.com/store/apps/details?id=com.aor.pocketgit) (others like SGit, Agit, Terminal IDE, Git, Gidder, etc. are pretty much unmaintained)
- [Server for PHP](https://play.google.com/store/apps/details?id=com.esminis.server.php) (others like Palapa, KSWeb, Servers Ultimate etc. are unmaintained)
- optional: [DroidEdit](https://play.google.com/store/apps/details?id=com.aor.droidedit) (or other text editor of your choice like AWD or Turbo Editor)

Steps to set it up:

1. Clone ownCloud core with Pocket Git using the https git URL to the www folder used by Server for PHP. (/storage/emulated/0/www)
2. Clone ownCloud 3rdparty too, Pocket Git does not support submodules yet. (/storage/emulated/0/www/3rdparty)
![](android-git.png)

3. Start Server for PHP (Permissions thankfully do not need to be adjusted!)
4. Navigate to the IP to finish setup. Will simply use SQLite as database.
![](android-server.png)

5. Maybe you need to manually add the IP (without the port) to trusted_domains in the config.php
