#!/bin/bash

set -e

echo "Deleting Homelab Demo App from Kubernetes..."

cd /srv/homelab/kubernetes/apps/demo-app

kubectl delete -f service.yaml --ignore-not-found=true
kubectl delete -f deployment.yaml --ignore-not-found=true
kubectl delete -f namespace.yaml --ignore-not-found=true

echo ""
echo "Demo app deleted from Kubernetes."
