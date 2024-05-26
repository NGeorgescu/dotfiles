echo "blacklist nvidia" | sudo tee /etc/modprobe.d/blacklist-nvidia.conf && echo "options nvidia modeset=0" | sudo tee -a /etc/modprobe.d/blacklist-nvidia.conf

