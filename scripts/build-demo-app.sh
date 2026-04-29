#!/bin/bash

set -e

APP_NAME="homelab-demo-app"
APP_VERSION="v1"
REGISTRY="192.168.1.18:5000"
IMAGE_NAME="$REGISTRY/$APP_NAME:$APP_VERSION"

echo "Building demo app Docker image..."
cd /srv/homelab/projects/demo-app
docker compose build

echo "Tagging image as $IMAGE_NAME..."
docker tag demo-app-demo-app:latest "$IMAGE_NAME"

echo "Pushing image to local Docker Registry..."
docker push "$IMAGE_NAME"

echo ""
echo "Image pushed successfully:"
echo "$IMAGE_NAME"

echo ""
echo "Registry catalog:"
curl http://192.168.1.18:5000/v2/_catalog
