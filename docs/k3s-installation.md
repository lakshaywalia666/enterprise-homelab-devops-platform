# K3s Kubernetes Installation

This document describes the K3s Kubernetes setup for the Enterprise Homelab DevOps Platform.

## Server

| Item | Value |
|---|---|
| Hostname | gateway-home-server |
| IP Address | 192.168.1.18 |
| OS | Ubuntu Server 24.04 LTS |
| Kubernetes Distribution | K3s |
| Node Type | Single-node control plane |

## K3s Install Command

K3s was installed with:

    curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --disable traefik --disable servicelb --write-kubeconfig-mode 644 --node-ip 192.168.1.18 --advertise-address 192.168.1.18" sh -

## Install Options

| Option | Purpose |
|---|---|
| --disable traefik | Disable bundled Traefik so custom ingress can be installed later |
| --disable servicelb | Disable bundled ServiceLB so MetalLB can be installed later |
| --write-kubeconfig-mode 644 | Allow normal user access to kubeconfig |
| --node-ip 192.168.1.18 | Bind node to static server IP |
| --advertise-address 192.168.1.18 | Advertise Kubernetes API on static server IP |

## Firewall Rule

| Port | Access | Purpose |
|---:|---|---|
| 6443 | 192.168.1.0/24 | Kubernetes API Server |

## Node Status

Command:

    kubectl get nodes -o wide

Expected result:

    gateway-home-server   Ready   control-plane   192.168.1.18

## System Pods

Command:

    kubectl get pods -A

Core pods:

| Namespace | Component | Status |
|---|---|---|
| kube-system | coredns | Running |
| kube-system | local-path-provisioner | Running |
| kube-system | metrics-server | Running |

## Kubeconfig

Normal user kubeconfig location:

    ~/.kube/config

Setup commands:

    mkdir -p ~/.kube
    cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
    chmod 600 ~/.kube/config

## Useful Commands

Check K3s service:

    sudo systemctl status k3s --no-pager

Check node:

    kubectl get nodes -o wide

Check all pods:

    kubectl get pods -A

Check Kubernetes API:

    kubectl cluster-info
