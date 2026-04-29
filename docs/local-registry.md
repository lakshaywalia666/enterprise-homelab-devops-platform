# Local Docker Registry

This document explains the local Docker Registry used in the Enterprise Homelab DevOps Platform.

## Registry Details

| Item | Value |
|---|---|
| Registry URL | 192.168.1.18:5000 |
| Container Name | homelab-registry |
| Image | registry:2 |
| Storage Path | /srv/homelab/data/registry |
| Compose File | /srv/homelab/docker/registry/docker-compose.yml |

## Purpose

The local registry stores Docker images built inside the homelab.

This allows the platform to follow a real deployment flow:

    Build image
    Tag image
    Push image to local registry
    Deploy image to runtime platform

Later, Kubernetes will pull images from this registry.

## Docker Daemon Configuration

Docker is configured to trust the local HTTP registry.

Configuration file:

    /etc/docker/daemon.json

Current config:

    {
      "insecure-registries": ["192.168.1.18:5000"],
      "live-restore": true
    }

## Example Image

Demo app image:

    192.168.1.18:5000/homelab-demo-app:v1

## Build and Push Script

Script path:

    /srv/homelab/scripts/build-demo-app.sh

Run:

    /srv/homelab/scripts/build-demo-app.sh

## Useful Commands

Check registry health:

    curl http://192.168.1.18:5000/v2/

Check registry catalog:

    curl http://192.168.1.18:5000/v2/_catalog

Tag image manually:

    docker tag demo-app-demo-app:latest 192.168.1.18:5000/homelab-demo-app:v1

Push image manually:

    docker push 192.168.1.18:5000/homelab-demo-app:v1

Pull image manually:

    docker pull 192.168.1.18:5000/homelab-demo-app:v1
