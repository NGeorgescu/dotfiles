#!/bin/bash

read -p "Enter the size of the swap file in GB: " swap_size
let kb_size=swap_size*1024*1024
sudo fallocate -l ${swap_size}G /swapfile
sudo dd if=/dev/zero of=/swapfile bs=1024 count=$kb_size
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo "/swapfile swap swap defaults 0 0" | sudo tee -a /etc/fstab

sudo swapon --show

