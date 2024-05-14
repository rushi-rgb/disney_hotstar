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
usermod -aG docker ubuntu 

echo "edit file /root/.ssh/authorized_keys"
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDZtsmlS0tfqaKoG7i2DPNPjZ/1GjPVG3T4xGjJnggg0TlqwAHeSgdQeqhVliayRk1nZhsiYJhc7zji3B3DjgSm8usFCz6D73Klxon4aGsGWrhkQfCc5rPqDnMI68rqMsCX6odBEU6wC20ZQzT+CMAIxhwdGdXL25Y1lO6mjQP/kgyv0s7RQXJ6RqwPgLsWOXPNYQ76TcAKQiIJCyVF9RIUPPpkvZVLX2/+Bi2f2/chJnq7K9cZuiWwo6m+Dei/7+3KI52DVdKvjl8Bp8cjwVrAeCaJrJUnWO9U2VTG9CPeCfCXfklkTx/EcsIAn39cJ1qfvpYQylI3MEEip0g33SsAPUFvCQqexqKVtgM/pN7uFx5ElN/pM0QPxPZQbk3Ah4Ebl/UL51YJ3az6QmOamlOzAZ4In2ktwGqDFzXQXCyzEKgNZSqDufUCHObI2dzf8i/CmxlLSmzKZj00dTR4z2w9ebzcHc35b7OJK5F1AHiNe8p4abAuK3crkZt6NYwZkCk= root@controlplane" >> /root/.ssh/authorized_keys

# Edit sshd_config file
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

# Restart SSH service (adjust the command based on your system)
sudo systemctl restart ssh
