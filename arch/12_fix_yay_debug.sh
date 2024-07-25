sudo cp /etc/makepkg.conf /etc/makepkg.conf.bak
sudo sed -i '/^OPTIONS=/s/!*\bdebug\b/!debug/' /etc/makepkg.conf
yay -Rnsc $(yay -Qqm | grep debug)
