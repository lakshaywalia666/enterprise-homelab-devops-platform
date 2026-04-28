#!/bin/bash

echo "========== SERVER =========="
hostname
uptime

echo ""
echo "========== IP ADDRESS =========="
ip -4 addr show | grep inet

echo ""
echo "========== DISK =========="
df -h

echo ""
echo "========== MEMORY =========="
free -h

echo ""
echo "========== DOCKER CONTAINERS =========="
docker ps

echo ""
echo "========== LISTENING PORTS =========="
sudo ss -tulpn
