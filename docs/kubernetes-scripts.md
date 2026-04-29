# Kubernetes Management Scripts

This document explains the Kubernetes helper scripts used in the Enterprise Homelab DevOps Platform.

## Scripts

| Script | Purpose |
|---|---|
| scripts/k8s-status.sh | Shows Kubernetes cluster, pods, services, metrics, and app health |
| scripts/deploy-demo-k8s.sh | Deploys the demo app to K3s Kubernetes |
| scripts/delete-demo-k8s.sh | Deletes the demo app from K3s Kubernetes |

## k8s-status.sh

Run:

    /srv/homelab/scripts/k8s-status.sh

This script checks:

    Kubernetes nodes
    Kubernetes namespaces
    All pods
    Homelab app resources
    Node metrics
    Pod metrics
    Kubernetes demo app health endpoint

Example checks included:

    kubectl get nodes -o wide
    kubectl get pods -A
    kubectl get all -n homelab-apps
    kubectl top nodes
    kubectl top pods -A
    curl http://192.168.1.18:30080/health

## deploy-demo-k8s.sh

Run:

    /srv/homelab/scripts/deploy-demo-k8s.sh

This script applies:

    namespace.yaml
    deployment.yaml
    service.yaml

It also waits for rollout status:

    kubectl rollout status deployment/homelab-demo-app -n homelab-apps

Then it checks the app health endpoint:

    curl http://192.168.1.18:30080/health

## delete-demo-k8s.sh

Run:

    /srv/homelab/scripts/delete-demo-k8s.sh

This script removes:

    Kubernetes service
    Kubernetes deployment
    Kubernetes namespace

It uses:

    --ignore-not-found=true

so the script does not fail if resources are already deleted.

## Demo App Kubernetes Resources

| Resource | Name |
|---|---|
| Namespace | homelab-apps |
| Deployment | homelab-demo-app |
| Service | homelab-demo-app-service |
| NodePort | 30080 |
| Image | 192.168.1.18:5000/homelab-demo-app:v1 |

## Useful Manual Commands

Check app resources:

    kubectl get all -n homelab-apps

Check pods:

    kubectl get pods -n homelab-apps -o wide

Check logs:

    kubectl logs -n homelab-apps -l app=homelab-demo-app

Restart deployment:

    kubectl rollout restart deployment/homelab-demo-app -n homelab-apps

Scale to 3 replicas:

    kubectl scale deployment homelab-demo-app -n homelab-apps --replicas=3

Scale back to 2 replicas:

    kubectl scale deployment homelab-demo-app -n homelab-apps --replicas=2
