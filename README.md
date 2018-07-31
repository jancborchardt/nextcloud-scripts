# :rainbow: :dancer: :hammer: How to

Set the permissions to run the script:

```
$ chmod a+x nextcloud-<action>-<platform>.sh
```

Run it:
```
$ chmod a+x nextcloud-<action>-<platform>.sh
```
## :pencil2: Apache configuration for symlinks

### :bangbang: “Symbolic link not allowed or link target not accessible"
:pushpin: The script creates a symlink from your home directory to the server folder. Apache will throw the error “Symbolic link not allowed or link target not accessible" in /var/log/apache2/error_log if you do not to configure it properly as described bellow.

#### :crocodile: openSUSE Linux

Add the following lines to /etc/apache2/default-server.conf:

```
        Options Indexes FollowSymLinks
        AllowOverride None
```

The settings need to be in ```<Directory "/srv/www/htdocs">```:

```
DocumentRoot "/srv/www/htdocs"

#
# Configure the DocumentRoot
#
<Directory "/srv/www/htdocs">
        Options Indexes FollowSymLinks
        AllowOverride None
        #Require all granted
```

Restart Apache:

```
$ sudo apache2ctl restart
```


###  :smiley_cat: Ubuntu

WIP
