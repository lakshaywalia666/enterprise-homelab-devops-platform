# Enterprise Homelab DevOps Platform Architecture

This document explains the architecture of the Enterprise Homelab DevOps Platform.

## Overview

This homelab simulates a real enterprise DevOps platform using an old laptop server.

The platform includes:

    Ubuntu Server
    Docker
    Docker Compose
    Local Docker Registry
    K3s Kubernetes
    Argo CD GitOps
    Uptime Kuma monitoring
    Portainer
    GitHub repository
    VS Code Remote SSH workflow

## Hardware

| Component | Details |
|---|---|
| Server | Old Gateway laptop |
| CPU | Intel i5 10th Gen |
| RAM | 16 GB |
| Storage | 2TB external drive |
| Server OS | Ubuntu Server 24.04 LTS |
| Server IP | 192.168.1.18 |
| Primary PC | Dell Windows PC |

## Main Directory

All project files are stored under:

    /srv/homelab

## High-Level Architecture

    Windows Dell PC
        |
        | SSH / VS Code Remote SSH
        v
    Ubuntu Homelab Server
        |
        | Docker + Docker Compose
        v
    Local Services
        |
        | Local Registry image push
        v
    K3s Kubernetes
        |
        | GitOps sync
        v
    Argo CD

## DevOps Flow

The current working flow is:

    Developer edits code
    Git commit and push to GitHub
    Docker image is built
    Image is pushed to local Docker Registry
    Kubernetes manifests are stored in GitHub
    Argo CD watches GitHub
    Argo CD syncs desired state to K3s
    K3s runs the application pods
    Uptime Kuma monitors service health

## Current Services

| Service | URL | Purpose |
|---|---|---|
| Portainer | https://192.168.1.18:9443 | Docker management |
| Uptime Kuma | http://192.168.1.18:3001 | Uptime monitoring |
| Local Docker Registry | http://192.168.1.18:5000 | Local image registry |
| Docker Demo App | http://192.168.1.18:8080 | Docker Compose demo app |
| Kubernetes Demo App | http://192.168.1.18:30080 | K3s deployed app |
| Argo CD | https://192.168.1.18:30443 | GitOps dashboard |

## GitOps Architecture

GitHub repository:

    enterprise-homelab-devops-platform

Argo CD application:

    homelab-demo-app

Argo CD watches this Git path:

    kubernetes/apps/demo-app

Kubernetes deployment image:

    192.168.1.18:5000/homelab-demo-app:v1

## Kubernetes Resources

| Resource | Value |
|---|---|
| Kubernetes Distribution | K3s |
| Namespace | homelab-apps |
| Deployment | homelab-demo-app |
| Replicas | 2 |
| Service Type | NodePort |
| NodePort | 30080 |
| Container Runtime | containerd |

## Monitoring

Uptime Kuma monitors:

    Docker Demo App
    Kubernetes Demo App
    Local Docker Registry
    Portainer
    SSH Server
    Argo CD Dashboard

## Security and Access

Firewall allows only local network access for management services.

| Port | Purpose |
|---:|---|
| 22 | SSH |
| 9443 | Portainer |
| 5000 | Local Docker Registry |
| 8080 | Docker Demo App |
| 3001 | Uptime Kuma |
| 6443 | Kubernetes API |
| 30080 | Kubernetes Demo App |
| 30088 | Argo CD HTTP |
| 30443 | Argo CD HTTPS |

## Important Scripts

| Script | Purpose |
|---|---|
| scripts/status.sh | Server and Docker status |
| scripts/start-services.sh | Start Docker services |
| scripts/stop-services.sh | Stop Docker services |
| scripts/build-demo-app.sh | Build and push demo app image |
| scripts/k8s-status.sh | Kubernetes status and health |
| scripts/deploy-demo-k8s.sh | Deploy demo app to K3s |
| scripts/delete-demo-k8s.sh | Delete demo app from K3s |

## Completed Milestones

| Milestone | Status |
|---|---|
| Server setup | Completed |
| SSH key login | Completed |
| VS Code Remote SSH | Completed |
| Docker installation | Completed |
| Portainer setup | Completed |
| Demo app Dockerization | Completed |
| Local Docker Registry | Completed |
| Uptime Kuma monitoring | Completed |
| K3s Kubernetes installation | Completed |
| Demo app Kubernetes deployment | Completed |
| Argo CD installation | Completed |
| GitOps deployment | Completed |
| GitOps scaling test | Completed |
| Documentation | Completed |

## Next Planned Improvements

    Helm chart for demo app
    Nginx Ingress Controller
    MetalLB
    Prometheus and Grafana
    Loki logs
    Trivy image scanning
    GitHub Actions or GitLab CI/CD
    Ansible automation
    Terraform structure
