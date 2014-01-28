#!/bin/bash
# Update ownCloud core and apps from latest git master
# Hopefully git submodules will supersede this eventually
# Jan-Christoph Borchardt, http://jancborchardt.net

# Change this path if you installed ownCloud somewhere else
cd $HOME/owncloud

echo
echo "Updating core ..."
git checkout master
git pull --quiet
echo "core updated. Latest changes:"
git --no-pager log -5 --pretty=format:"%h %Cblue%ar%x09%an %Creset%s"
echo "Removing merged branches ..."
git branch --merged master | grep -v 'master$' | xargs git branch -d
echo

echo "Updating 3rdparty submodule ..."
git submodule update
echo

echo "Updating apps ..."
cd apps2
git checkout master
git pull --quiet
echo "apps updated. Latest changes:"
git --no-pager log -5 --pretty=format:"%h %Cblue%ar%x09%an %Creset%s"
echo "Removing merged branches ..."
git branch --merged master | grep -v 'master$' | xargs git branch -d
cd ..
echo

cd apps
for APP in appframework bookmarks calendar chat contacts documents maps music news notes tasks videos
do
  if [ -d "$APP" ]; then
    echo "Updating $APP ..."
    cd $APP
    git checkout master
    git pull --quiet
    echo $APP "updated. Latest changes:"
    git --no-pager log -5 --pretty=format:"%h %Cblue%ar%x09%an %Creset%s"
    echo "Removing merged branches ..."
    git branch --merged master | grep -v 'master$' | xargs git branch -d
    cd ..
    echo
  fi
done

echo
echo "Everything updated!"
echo "Now get coding and fix some bugs! :)"
echo
