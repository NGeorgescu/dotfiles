sudo tee /etc/pacman.d/hooks/scroll_fix.hook <<EOF
[Trigger]
Operation = Install, Upgrade, Remove
Type = Package
Target = *

[Action]
Description = fixing natural scrolling
When = PostTransaction
Exec = /home/nsg/Dropbox/Files/i3cmds/natural_scrolling
EOF
