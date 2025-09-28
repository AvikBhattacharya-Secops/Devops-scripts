#!/bin/bash

# Clean up Docker system
echo "Pruning Docker system..."
docker system prune -a -f
docker volume prune -f

# Restart Jenkins service
echo "Stopping Jenkins..."
net stop Jenkins
echo "Starting Jenkins..."
net start Jenkins

# Alternatively using PowerShell for Jenkins restart (Windows only)
echo "Restarting Jenkins service..."
Restart-Service -Name Jenkins

# Checking Jenkins service status
echo "Checking Jenkins service status..."
sudo systemctl status jenkins

# Display disk usage
echo "Disk space usage:"
df -h

# Clean Jenkins workspace
echo "Cleaning Jenkins workspace..."
sudo rm -rf /var/lib/jenkins/workspace/*

# Clean package cache
echo "Cleaning package cache..."
sudo apt-get clean

# Find the top 20 largest files in the system
echo "Finding the largest files in the system..."
sudo du -ah / | sort -rh | head -n 20

# Clean Jenkins build directories
echo "Cleaning Jenkins build directories..."
sudo rm -rf /var/lib/jenkins/jobs/*/builds/*

# List snap packages and all installed revisions
echo "Listing all snap packages and revisions..."
sudo snap list --all

# Remove specific old snap revision
echo "Removing old snap revision..."
sudo snap remove --revision=<old-revision>

# Set snap system refresh retention
echo "Setting snap system refresh retention..."
sudo snap set system refresh.retain=2

# Final clean up
echo "Cleaning apt-get cache again..."
sudo apt-get clean

# Restart Jenkins service again
echo "Restarting Jenkins service..."
sudo systemctl restart jenkins

# Check Jenkins service status
echo "Checking Jenkins service status after restart..."
sudo systemctl status jenkins

echo "Script execution complete."
