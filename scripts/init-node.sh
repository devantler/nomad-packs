#!/bin/bash
# Update and upgrade system
sudo apt update 
sudo apt upgrade -y
# Install git
sudo apt install -y git
# Configure for auto upgrades
sudo apt install -y unattended-upgrades
sudo dpkg-reconfigure --priority=low unattended-upgrades
# Install Docker and Docker Compose
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
sudo apt install -y libffi-dev libssl-dev
sudo apt install -y python3-dev
sudo apt install -y python3 python3-pip
sudo pip3 install docker-compose
sudo systemctl enable docker
# Restart system and cleanup
sudo shutdown -r