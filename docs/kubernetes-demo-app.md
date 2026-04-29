# Kubernetes Demo App Deployment

This document explains how the demo app is deployed on K3s Kubernetes inside the Enterprise Homelab DevOps Platform.

## Deployment Summary

| Item | Value |
|---|---|
| App Name | homelab-demo-app |
| Namespace | homelab-apps |
| Kubernetes Distribution | K3s |
| Replicas | 2 |
| Image | 192.168.1.18:5000/homelab-demo-app:v1 |
| Service Type | NodePort |
| NodePort | 30080 |
| Health URL | http://192.168.1.18:30080/health |

## Deployment Flow

The app follows this deployment flow:

    Node.js app
    Docker image build
    Push image to local Docker Registry
    K3s pulls image from local Registry
    Kubernetes runs 2 replicas
    NodePort exposes the app on port 30080

## Files

Kubernetes manifests are stored here:

    /srv/homelab/kubernetes/apps/demo-app/

Files:

| File | Purpose |
|---|---|
| namespace.yaml | Creates the homelab-apps namespace |
| deployment.yaml | Runs the demo app with 2 replicas |
| service.yaml | Exposes the app using NodePort 30080 |

## Apply Deployment

Run:

    cd /srv/homelab/kubernetes/apps/demo-app
    kubectl apply -f namespace.yaml
    kubectl apply -f deployment.yaml
    kubectl apply -f service.yaml

## Check Deployment

Check all resources:

    kubectl get all -n homelab-apps

Check pods:

    kubectl get pods -n homelab-apps -o wide

Check deployment:

    kubectl get deployment -n homelab-apps

Check service:

    kubectl get svc -n homelab-apps

## Test App

Test root endpoint:

    curl http://192.168.1.18:30080

Test health endpoint:

    curl http://192.168.1.18:30080/health

Expected health response:

    {"status":"healthy"}

## Current Working State

| Resource | Status |
|---|---|
| Deployment | 2/2 Available |
| Pods | 2/2 Running |
| Service | NodePort 30080 |
| Health Check | Healthy |

## Useful Commands

Restart deployment:

    kubectl rollout restart deployment homelab-demo-app -n homelab-apps

Check rollout status:

    kubectl rollout status deployment homelab-demo-app -n homelab-apps

View logs:

    kubectl logs -n homelab-apps -l app=homelab-demo-app

Scale app to 3 replicas:

    kubectl scale deployment homelab-demo-app -n homelab-apps --replicas=3

Scale app back to 2 replicas:

    kubectl scale deployment homelab-demo-app -n homelab-apps --replicas=2

Delete app:

    kubectl delete -f /srv/homelab/kubernetes/apps/demo-app/
