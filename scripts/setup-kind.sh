#!/bin/bash

# Check if kind is already installed
if ! command -v kind &> /dev/null; then
    echo "Kind is not installed. Installing Kind..."

    # Detect OS type and architecture
    OS=$(uname -s)
    ARCH=$(uname -m)

    # Determine the correct binary URL
    if [[ "$OS" == "Darwin" && "$ARCH" == "x86_64" ]]; then
        KIND_BINARY_URL="https://kind.sigs.k8s.io/dl/v0.20.0/kind-darwin-amd64"
    elif [[ "$OS" == "Darwin" && "$ARCH" == "arm64" ]]; then
        KIND_BINARY_URL="https://kind.sigs.k8s.io/dl/v0.20.0/kind-darwin-arm64"
    elif [[ "$OS" == "Linux" && "$ARCH" == "x86_64" ]]; then
        KIND_BINARY_URL="https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64"
    else
        echo "Unsupported OS or architecture: $OS $ARCH"
        exit 1
    fi

    # Download the binary
    echo "Downloading kind from $KIND_BINARY_URL..."
    curl -Lo ./kind "$KIND_BINARY_URL"

    # Make the binary executable
    chmod +x ./kind

    # Move the binary to a directory in the PATH
    sudo mv ./kind /usr/local/bin/kind
fi

# Verify kind is installed
kind version

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