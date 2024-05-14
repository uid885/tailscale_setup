#!/bin/bash -
##########################################################
# Author:      Christo Deale                  
# Date  :      2023-0              
# tailscale_setup: Utility to install Tailscale on RHEL9
##########################################################
# Verify if Tailscale is already installed
if ! command -v tailscale &> /dev/null; then
    echo "Tailscale is not installed. Proceeding with installation..."
    curl -fsSL https://tailscale.com/install.sh | sh
    sudo dnf config-manager --add-repo https://pkgs.tailscale.com/stable/rhel/9/tailscale.repo
    sudo dnf install tailscale -y
    sudo systemctl enable --now tailscaled
else
    echo "Tailscale is already installed."
fi

# Start Tailscale
sudo tailscale up

# Start Tailscale SSH
tailscale up --ssh

# Display the Tailscale IP address
tailscale ip -4
