#!/bin/bash

# make a backup for a typical Linux desktop box
# assumes no file exists at paths and is likely to clobber anything there; I've not tested it that way
# only backs up non-root user profile that's currently logged in, and excludes some cache crap

# Need enough space on disk for it, and root permissions to creat/move/delete
# the backup once created!

# setup variables to be used below
theuser=`whoami`
thedate=`date +%Y-%m-%d`
filename="$thedate"_"$theuser".tgz

# move into main home folder
cd /home

# make the archive, excluding some browser/cache stuff
sudo tar -czvf $filename --exclude=$theuser/.config/google-chrome --exclude=$theuser/snap/firefox/common/.cache/mozilla/firefox --exclude=$theuser/.cache --exclude=$theuser/.thunderbird $theuser/

# blank line of terminal output:
echo

# communicate status update and next step with end-user
echo "backup done; need to change ownership..."
# this is needed so the end-user can do things with the file, and it's not "locked" as root
sudo chown $theuser:$theuser $filename

# communicate status update and next step with end-user
echo "need to move to user's home folder..."
# this is needed because while the user can read the file, they can't "rm" it from /home since /home permissions are restricted
sudo mv $filename $theuser/$filename

# communicate status update with end-user
echo "done createing backup! see it at"
# communicate path/filename to end-user
echo "/home/$theuser/$filename"
