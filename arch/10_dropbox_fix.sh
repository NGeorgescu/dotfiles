#!/bin/bash

dropbox stop

sleep 30

rm -R ~/Dropbox/.dropbox.cache/*
sudo chown -R "$USER" "$HOME/Dropbox"
sudo chattr -R -i "$HOME/Dropbox"
chmod -R u+rw "$HOME/Dropbox"

rm -rf ~/.dropbox-dist
mkdir ~/.dropbox-dist
chmod a-w ~/.dropbox-dist



dropbox start
