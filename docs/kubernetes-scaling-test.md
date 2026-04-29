# Kubernetes Scaling Test

This document records a manual Kubernetes scaling test for the Enterprise Homelab DevOps Platform.

## App

| Item | Value |
|---|---|
| App Name | homelab-demo-app |
| Namespace | homelab-apps |
| Deployment | homelab-demo-app |
| Image | 192.168.1.18:5000/homelab-demo-app:v1 |
| Service | homelab-demo-app-service |
| NodePort | 30080 |

## Test Goal

Verify that the Kubernetes deployment can scale replicas up and down successfully.

## Initial State

The deployment was running with 2 replicas:

    kubectl get deployment homelab-demo-app -n homelab-apps

Expected:

    READY: 2/2

## Scale Up Test

Command:

    kubectl scale deployment homelab-demo-app -n homelab-apps --replicas=3

Check rollout:

    kubectl rollout status deployment/homelab-demo-app -n homelab-apps

Check pods:

    kubectl get pods -n homelab-apps -o wide

Result:

    Deployment successfully scaled from 2 replicas to 3 replicas.

## Health Check

Command:

    curl http://192.168.1.18:30080/health

Result:

    {"status":"healthy"}

## Scale Down Test

Command:

    kubectl scale deployment homelab-demo-app -n homelab-apps --replicas=2

Check rollout:

    kubectl rollout status deployment/homelab-demo-app -n homelab-apps

Final check:

    kubectl get deployment homelab-demo-app -n homelab-apps
    kubectl get pods -n homelab-apps -o wide

Result:

    Deployment successfully scaled back from 3 replicas to 2 replicas.

## Final State

| Resource | Result |
|---|---|
| Deployment | 2/2 Ready |
| Pods | 2 Running |
| Service | Available on NodePort 30080 |
| Health Check | Healthy |

## Notes

This was a manual Kubernetes scaling test using kubectl.

The next improvement will be GitOps-based scaling using Argo CD:

    Edit replicas in Git
    Commit and push
    Argo CD syncs the cluster
    Pods increase or decrease automatically
