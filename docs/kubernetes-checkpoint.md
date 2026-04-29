# Kubernetes Checkpoint

This document records the first working Kubernetes checkpoint for the Enterprise Homelab DevOps Platform.

## Cluster

| Item | Value |
|---|---|
| Kubernetes Distribution | K3s |
| Node | gateway-home-server |
| Node IP | 192.168.1.18 |
| Role | control-plane |
| Runtime | containerd |
| Status | Ready |

## Core Components

| Component | Namespace | Status |
|---|---|---|
| CoreDNS | kube-system | Running |
| Local Path Provisioner | kube-system | Running |
| Metrics Server | kube-system | Running |

## Local Registry Integration

K3s is configured to use the local Docker Registry.

Registry config file:

    /etc/rancher/k3s/registries.yaml

Config:

    mirrors:
      "192.168.1.18:5000":
        endpoint:
          - "http://192.168.1.18:5000"

Local registry image available:

    192.168.1.18:5000/homelab-demo-app:v1

## Verification Commands

Check nodes:

    kubectl get nodes -o wide

Check pods:

    kubectl get pods -A

Check Metrics API:

    kubectl top nodes

Check registry catalog:

    curl http://192.168.1.18:5000/v2/_catalog

## Current Metrics Example

Example output:

    gateway-home-server   CPU 2%   Memory 15%

## Notes

The Metrics API initially showed unavailable after K3s restart. Restarting the metrics-server deployment fixed the APIService registration:

    kubectl -n kube-system rollout restart deployment metrics-server
