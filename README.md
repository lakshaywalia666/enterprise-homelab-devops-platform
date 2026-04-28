# Enterprise Homelab DevOps Platform

This is my personal enterprise-style DevOps homelab built on an old Gateway laptop server.

## Server Details

- Server IP: 192.168.1.18
- Server User: lw
- Main Directory: /srv/homelab
- Purpose: DevOps, Docker, Kubernetes, CI/CD, Monitoring, GitOps, Automation

## Planned Stack

- Ubuntu Server
- Docker
- Docker Compose
- Portainer
- Git
- GitLab CI/CD
- GitLab Runner
- K3s Kubernetes
- Helm
- Argo CD
- Prometheus
- Grafana
- Loki
- Alertmanager
- Terraform
- Ansible
- Trivy
- cert-manager

## Folder Structure

- projects/      : Application source code
- docker/        : Docker Compose services
- kubernetes/    : Kubernetes manifests, Helm charts, Argo CD apps
- infra/         : Terraform and Ansible automation
- data/          : Persistent Docker/Kubernetes data
- backups/       : Backup files
- scripts/       : Useful automation scripts
- secrets/       : Private secrets, never push to GitHub
- logs/          : Custom logs
- docs/          : Notes and documentation
