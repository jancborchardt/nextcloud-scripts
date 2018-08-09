#!/bin/bash
# Update Nextcloud server & apps from latest git master
# Perfect for local development environment
# Jan-Christoph Borchardt, http://jancborchardt.net

# Change this path if you installed Nextcloud somewhere else
cd $HOME/Projects/Nextcloud/nextcloud

echo
echo "Updating core ..."
git checkout master
git pull --quiet
echo "core updated. Latest changes:"
git --no-pager log -5 --pretty=format:"%h %Cblue%ar%x09%an %Creset%s"
echo
echo "Removing merged branches ..."
git branch --merged master | grep -v 'master$' | xargs git branch -d
git fetch --prune --quiet
echo

echo "Updating 3rdparty submodule ..."
git submodule update --init
echo

cd apps
for APP in activity bookmarks calendar circles contacts deck files_filter files_pdfviewer files_texteditor files_videoplayer firstrunwizard gallery jsxc.nextcloud logreader mail maps news nextcloud_announcements notes notifications password_policy richdocuments serverinfo socialsharing spreed survey_client tasks user_external end_to_end_encryption
do
  if [ -d "$APP" ]; then
    echo "Updating $APP ..."
    cd $APP
    git checkout master
    git pull --quiet
    echo $APP "updated. Latest changes:"
    git --no-pager log -5 --pretty=format:"%h %Cblue%ar%x09%an %Creset%s"
    echo
    echo "Removing merged branches ..."
    git branch --merged master | grep -v 'master$' | xargs git branch -d
    git fetch --prune --quiet
    cd ..
    echo
  else
    echo "$APP folder not found. If you want to install it clone it first. Otherwise ignore this note."
  fi
done

echo
echo "Everything updated!"
echo "Now get coding and fix some bugs! :)"
echo
