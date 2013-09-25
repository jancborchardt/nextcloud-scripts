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
git log -5 --pretty=format:"%h %Cblue%ar%x09%an %Creset%s"
echo

echo "Updating 3rdparty ..."
cd 3rdparty
git checkout master
git pull --quiet
echo "3rdparty updated. Latest changes:"
git log -5 --pretty=format:"%h %Cblue%ar%x09%an %Creset%s"
cd ..
echo

echo "Updating apps ..."
cd apps2
git checkout master
git pull --quiet
echo "apps updated. Latest changes:"
git log -5 --pretty=format:"%h %Cblue%ar%x09%an %Creset%s"
cd ..
echo

cd apps
for APP in appframework bookmarks calendar contacts documents maps music news notes tasks
do
  echo "Updating $APP ..."
  cd $APP
  git checkout master
  git pull --quiet
  echo $APP "updated. Latest changes:"
  git log -5 --pretty=format:"%h %Cblue%ar%x09%an %Creset%s"
  cd ..
  echo
done

echo
echo "Everything updated!"
echo "Now get coding and fix some bugs! :)"
echo
