# Argo CD GitOps Scaling Test

This document records the GitOps-based scaling test for the Enterprise Homelab DevOps Platform.

## Goal

Verify that Kubernetes scaling can be controlled from Git using Argo CD.

Instead of manually running:

    kubectl scale deployment homelab-demo-app -n homelab-apps --replicas=3

the replica count was changed in Git:

    kubernetes/apps/demo-app/deployment.yaml

## Application

| Item | Value |
|---|---|
| Argo CD App | homelab-demo-app |
| Namespace | homelab-apps |
| Deployment | homelab-demo-app |
| Image | 192.168.1.18:5000/homelab-demo-app:v1 |
| Service | homelab-demo-app-service |
| NodePort | 30080 |
| Health URL | http://192.168.1.18:30080/health |

## GitOps Scale Up: 2 to 3 Replicas

Changed:

    replicas: 2

to:

    replicas: 3

Committed and pushed to GitHub:

    git add kubernetes/apps/demo-app/deployment.yaml
    git commit -m "Scale demo app to 3 replicas using GitOps"
    git push

Forced Argo CD refresh:

    kubectl -n argocd annotate application homelab-demo-app argocd.argoproj.io/refresh=hard --overwrite

Result:

    Argo CD: Synced and Healthy
    Deployment: 3/3 Ready
    Pods: 3 Running
    Health endpoint: healthy

## GitOps Scale Down: 3 to 2 Replicas

Changed:

    replicas: 3

to:

    replicas: 2

Committed and pushed to GitHub:

    git add kubernetes/apps/demo-app/deployment.yaml
    git commit -m "Scale demo app back to 2 replicas using GitOps"
    git push

Forced Argo CD refresh:

    kubectl -n argocd annotate application homelab-demo-app argocd.argoproj.io/refresh=hard --overwrite

Result:

    Argo CD: Synced and Healthy
    Deployment: 2/2 Ready
    Pods: 2 Running
    Health endpoint: healthy

## Final State

| Resource | Final State |
|---|---|
| Argo CD Application | Synced and Healthy |
| Deployment | 2/2 Ready |
| Pods | 2 Running |
| Service | Available on NodePort 30080 |
| Health Check | Healthy |

## Verification Commands

Check Argo CD app:

    kubectl get applications -n argocd

Check deployment:

    kubectl get deployment homelab-demo-app -n homelab-apps

Check pods:

    kubectl get pods -n homelab-apps -o wide

Check health endpoint:

    curl http://192.168.1.18:30080/health

## Conclusion

This test proves that the homelab supports GitOps-based Kubernetes operations.

The desired state is stored in GitHub, Argo CD syncs the desired state into K3s, and Kubernetes updates the running pods automatically.
