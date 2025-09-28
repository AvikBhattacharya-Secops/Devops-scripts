#!/bin/bash

# Clean up unused Docker resources
echo "Cleaning up unused Docker resources..."
docker system prune -a -f

# Remove unused Docker volumes
echo "Removing unused Docker volumes..."
docker volume prune -f

# Stop Jenkins service (For Linux, replace with systemctl stop jenkins)
echo "Stopping Jenkins service..."
net stop Jenkins

# Start Jenkins service (For Linux, replace with systemctl start jenkins)
echo "Starting Jenkins service..."
net start Jenkins

# Restart Jenkins service using PowerShell (For Windows only)
echo "Restarting Jenkins service..."
Restart-Service -Name Jenkins

# Check Jenkins status
echo "Checking Jenkins status..."
sudo systemctl status jenkins

# Clear terminal screen
clear

# Check disk usage
echo "Checking disk usage..."
df -h

# Remove Jenkins build history
echo "Removing Jenkins build history..."
sudo rm -rf /var/lib/jenkins/jobs/*/builds/*

# Clean up Jenkins workspace
echo "Cleaning up Jenkins workspace..."
sudo rm -rf /var/lib/jenkins/workspace/*

# Clean apt-get cache
echo "Cleaning apt-get cache..."
sudo apt-get clean

# List top 20 largest files and directories
echo "Listing top 20 largest files and directories..."
sudo du -ah / | sort -rh | head -n 20

# Remove Jenkins build history again (just in case)
echo "Removing Jenkins build history again..."
sudo rm -rf /var/lib/jenkins/jobs/*/builds/*

# List installed Jenkins plugins
echo "Listing Jenkins plugins..."
ls /var/lib/jenkins/plugins

# Remove specific Jenkins plugin (Replace plugin-name with actual plugin name)
echo "Removing specific Jenkins plugin..."
sudo rm /var/lib/jenkins/plugins/plugin-name.jpi

# Remove Git-related Jenkins plugins
echo "Removing Git-related Jenkins plugins..."
sudo rm /var/lib/jenkins/plugins/git.*

# List all installed snap packages
echo "Listing installed snap packages..."
sudo snap list --all

# Remove an old revision of a snap package
echo "Removing old revision of snap package..."
sudo snap remove --revision=<old-revision>

# Set snap package retention to 2
echo "Setting snap package retention to 2..."
sudo snap set system refresh.retain=2

# Clean apt-get cache again
echo "Cleaning apt-get cache again..."
sudo apt-get clean

# Restart Jenkins service
echo "Restarting Jenkins service..."
sudo systemctl restart jenkins

# Check Jenkins status again
echo "Checking Jenkins status after restart..."
sudo systemctl status jenkins

echo "Jenkins cleanup completed!"
