#!/bin/bash

# Create a multi-node KinD cluster
cat <<EOF | kind create cluster --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
EOF

# Verify cluster is up
kubectl cluster-info