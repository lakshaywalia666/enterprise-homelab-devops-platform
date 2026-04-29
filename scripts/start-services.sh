#!/bin/bash

set -e

echo "Starting Portainer..."
cd /srv/homelab/docker/portainer
docker compose up -d

echo "Starting Registry..."
cd /srv/homelab/docker/registry
docker compose up -d

echo "Starting Uptime Kuma..."
cd /srv/homelab/docker/uptime-kuma
docker compose up -d

echo "Starting Demo App..."
cd /srv/homelab/projects/demo-app
docker compose up -d

echo ""
echo "All services started."
docker ps
