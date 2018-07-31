# How to

Set the permissions to run the script:

```
$ chmod a+x nextcloud-<action>-<platform>.sh

```

Run it:
```
$ chmod a+x nextcloud-<action>-<platform>.sh

```

*After or before running the scripts, do not forget to set Apache to allow the synmlink from your home directory to the server folder. You can check for errors in /var/log/apache2/error_log - it will be something like “Symbolic link not allowed or link target not accessible".*

## Apache configuration for symlinks

### openSUSE Linux

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


### Ubuntu

WIP