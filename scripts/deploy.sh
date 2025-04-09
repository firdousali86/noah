#!/bin/bash

# Apply NGINX Ingress Controller
kubectl apply -f k8s/ingress-controller.yaml

# Wait for Ingress Controller to be ready
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app=nginx-ingress \
  --timeout=120s

# Apply foo deployment and service
kubectl apply -f k8s/foo-deployment.yaml

# Apply bar deployment and service
kubectl apply -f k8s/bar-deployment.yaml

# Apply Ingress resource
kubectl apply -f k8s/ingress.yaml

# Wait for deployments to be ready
kubectl rollout status deployment/foo-deployment
kubectl rollout status deployment/bar-deployment