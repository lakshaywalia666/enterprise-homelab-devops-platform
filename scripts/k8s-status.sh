#!/bin/bash

set -e

echo "========== KUBERNETES NODES =========="
kubectl get nodes -o wide

echo ""
echo "========== KUBERNETES NAMESPACES =========="
kubectl get namespaces

echo ""
echo "========== ALL PODS =========="
kubectl get pods -A

echo ""
echo "========== HOMELAB APPS =========="
kubectl get all -n homelab-apps

echo ""
echo "========== NODE METRICS =========="
kubectl top nodes || echo "Metrics not available yet"

echo ""
echo "========== POD METRICS =========="
kubectl top pods -A || echo "Pod metrics not available yet"

echo ""
echo "========== DEMO APP HEALTH =========="
curl -s http://192.168.1.18:30080/health || echo "Kubernetes demo app health check failed"
echo ""
