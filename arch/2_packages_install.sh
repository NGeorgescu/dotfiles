#!/bin/bash
yay -Syu --needed $(cat packages.txt)
yay -Rnsc xdg-desktop-portal-gnome
