# Argo CD Installation

This document describes the Argo CD installation for the Enterprise Homelab DevOps Platform.

## Purpose

Argo CD is used for GitOps-based Kubernetes deployment.

It will allow the platform to deploy Kubernetes applications from Git and continuously compare:

    Desired state in Git
    Live state in Kubernetes

## Installation

Namespace:

    argocd

Install command:

    kubectl create namespace argocd
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

## Argo CD Pods

Check pods:

    kubectl get pods -n argocd

Expected core components:

    argocd-application-controller
    argocd-applicationset-controller
    argocd-dex-server
    argocd-notifications-controller
    argocd-redis
    argocd-repo-server
    argocd-server

## Argo CD Dashboard Access

The argocd-server service was exposed using NodePort.

Check service:

    kubectl get svc argocd-server -n argocd

Dashboard:

    https://192.168.1.18:30443

NodePorts:

| Port | Purpose |
|---:|---|
| 30088 | HTTP |
| 30443 | HTTPS |

## Firewall Rules

| Port | Access | Purpose |
|---:|---|---|
| 30088 | 192.168.1.0/24 | Argo CD HTTP |
| 30443 | 192.168.1.0/24 | Argo CD HTTPS |

## Login

Default username:

    admin

Initial password command:

    kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

## Useful Commands

Check Argo CD pods:

    kubectl get pods -n argocd

Check Argo CD services:

    kubectl get svc -n argocd

Check Argo CD server service:

    kubectl get svc argocd-server -n argocd

Restart Argo CD server:

    kubectl rollout restart deployment argocd-server -n argocd
