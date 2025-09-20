#!/bin/bash

echo "🔄 Updating package list..."
sudo apt update

echo "✅ System is ready for installing or upgrading software."

echo "📦 Installing Docker..."
sudo apt install docker.io -y

echo "🚀 Starting Docker service..."
sudo systemctl start docker

echo "🔁 Ensuring Docker service is running..."
sudo systemctl start docker  # Redundant but included as requested

echo "🔍 Checking Docker version..."
docker --version

echo "📊 Checking Docker service status..."
sudo systemctl status docker

echo "👤 Adding current user to Docker group (optional)..."
sudo usermod -aG docker $(whoami)

echo "📦 Installing Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/v2.24.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "🔍 Checking Docker Compose version..."
docker-compose --version

echo "✅ Docker and Docker Compose installation complete!"
echo "🔁 Please log out and log back in to apply group changes if needed."
