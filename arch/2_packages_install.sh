#!/bin/bash
yay -Syu --needed $(cat packages.txt)
yay -R xdg-desktop-portal-gnome
