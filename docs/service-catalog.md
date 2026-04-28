# Homelab Service Catalog

This document tracks all services running in the Enterprise Homelab DevOps Platform.

## Server

| Item | Value |
|---|---|
| Hostname | gateway-home-server |
| IP Address | 192.168.1.18 |
| Main Directory | /srv/homelab |
| OS | Ubuntu Server 24.04 LTS |

## Running Services

| Service | URL | Port | Purpose |
|---|---|---:|---|
| Portainer | https://192.168.1.18:9443 | 9443 | Docker management dashboard |
| Demo App | http://192.168.1.18:8080 | 8080 | Sample Dockerized application |
| Uptime Kuma | http://192.168.1.18:3001 | 3001 | Uptime monitoring dashboard |

## Firewall Rules

| Port | Access | Purpose |
|---:|---|---|
| 22 | 192.168.1.0/24 | SSH |
| 9443 | 192.168.1.0/24 | Portainer |
| 8080 | 192.168.1.0/24 | Demo App |
| 3001 | 192.168.1.0/24 | Uptime Kuma |
| 22 | 172.20.0.0/16 | Uptime Kuma SSH monitor |

## Docker Containers

| Container | Image | Status |
|---|---|---|
| portainer | portainer/portainer-ce | Running |
| homelab-demo-app | demo-app-demo-app | Healthy |
| uptime-kuma | louislam/uptime-kuma | Healthy |

## Useful Commands

Check server status:

```bash
/srv/homelab/scripts/status.sh
Check Docker containers:

docker ps

Go to homelab folder:

cd /srv/homelab

