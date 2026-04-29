#!/bin/bash

set -e

echo "Deploying Homelab Demo App to Kubernetes..."

cd /srv/homelab/kubernetes/apps/demo-app

kubectl apply -f namespace.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

echo ""
echo "Waiting for deployment rollout..."
kubectl rollout status deployment/homelab-demo-app -n homelab-apps

echo ""
echo "Current Kubernetes resources:"
kubectl get all -n homelab-apps

echo ""
echo "Testing health endpoint:"
curl -s http://192.168.1.18:30080/health
echo ""
