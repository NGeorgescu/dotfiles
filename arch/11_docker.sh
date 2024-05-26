#!/bin/bash
sudo systemctl enable --now docker
# Adds the current user to the docker group
sudo usermod -aG docker $USER

# Outputs a message to restart the session
echo "User '$USER' added to 'docker' group. Please log out and log back in for this to take effect."

