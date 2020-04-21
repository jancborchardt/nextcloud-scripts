# 🤖☁️ [Nextcloud](https://nextcloud.com) on Android

**Set up a [Nextcloud](https://nextcloud.com) server and development environment on your Android device.** This is useful if you are on the move and need to test things, or have an extra device you want to use as your own server.

## Clone code using [MGit](https://f-droid.org/packages/com.manichord.mgit/) (optional, you can also just use the terminal)
- Set "root storage location for repos" to something like `/storage/emulated/0`
- Clone with: Remote URL `https://github.com/nextcloud/server.git`, Local Path `nextcloud` (doesn’t support 2FA – if you use that [get an app token](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/) and log in with that)
- Clone the 3rdparty submodule too, local path `nextcloud/3rdparty`

## Install (and optionally clone as well) with [Termux](https://termux.com/)
- First install some dependencies `pkg install php php-fpm sqlite coreutils openssl-tool git`
- Allow Termux to access storage outside of own folder `termux-setup-storage`
- (If you want to clone with Termux: `cd /storage/emulated/0/ && git clone https://github.com/nextcloud/server.git nextcloud &&  git clone https://github.com/nextcloud/3rthparty.git nextcloud/3rdparty`)
- Get the Nextcloud submodules `cd /storage/emulated/0/nextcloud/ && git submodule update --init`
- Start the server `php -S 0.0.0.0:8080 -t /storage/emulated/0/nextcloud/`

## Finish setup in [Firefox](https://www.mozilla.org/firefox/android/)
- Go to `http://0.0.0.0:8080`
- Set an admin username and password in the
- (SQLite will be used as database)

## 🎉
Now you can check out branches and test them, or even edit files in some code editor. :)
