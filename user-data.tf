#!/bin/bash

# Update the package list and upgrade the installed packages
sudo apt-get update -y

# Install OpenJDK headless without recommended packages
sudo apt install -y --no-install-recommends openjdk-17-jdk-headless

# Install Docker
sudo apt-get install -y docker.io

# Start the Docker service
sudo systemctl start docker
sudo systemctl enable docker

echo "edit file /root/.ssh/authorized_keys"
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEb+YYTxoS7XCOzWbu2ikAdF70ciZZGEjK2e7NuOVLVF root@ip-172-31-26-4" >> /root/.ssh/authorized_keys

# Edit sshd_config file
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

# Restart SSH service (adjust the command based on your system)
sudo systemctl restart ssh


