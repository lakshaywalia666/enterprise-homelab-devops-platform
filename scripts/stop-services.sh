#!/bin/bash

set -e

echo "Stopping Demo App..."
cd /srv/homelab/projects/demo-app
docker compose down

echo "Stopping Uptime Kuma..."
cd /srv/homelab/docker/uptime-kuma
docker compose down

echo "Stopping Portainer..."
cd /srv/homelab/docker/portainer
docker compose down

echo ""
echo "All services stopped."
docker ps
