#!/bin/bash

# Script to install Helm, ArgoCD via Helm, and expose ArgoCD

# Ensure script is being run as root or with sudo privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root or with sudo privileges"
    exit 1
fi

# Update system
echo "Updating system..."
apt-get update -y
apt-get upgrade -y

# Install necessary dependencies
echo "Installing dependencies..."
apt-get install -y curl apt-transport-https

# Install Helm (via Helm's script)
echo "Installing Helm..."
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Verify Helm installation
echo "Verifying Helm installation..."
helm version

# Add Helm repositories
echo "Adding Helm repositories..."
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

# Create the ArgoCD namespace
echo "Creating ArgoCD namespace..."
kubectl create namespace argocd

# Install ArgoCD using Bitnami's Helm chart
echo "Installing ArgoCD..."
helm install argocd bitnami/argo-cd --namespace argocd

# Expose ArgoCD server via NodePort
echo "Exposing ArgoCD server via NodePort..."
kubectl patch svc argocd-argo-cd-server -n argocd -p '{"spec": {"type": "NodePort"}}'

# Get external IP and port for access
echo "Fetching external IP and port for ArgoCD..."
kubectl get svc argocd-argo-cd-server -n argocd

# Retrieve the initial admin password
echo "Retrieving ArgoCD initial admin password..."
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

# Install ArgoCD CLI
echo "Installing ArgoCD CLI..."
curl -sSL -o argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
chmod +x argocd
sudo mv argocd /usr/local/bin/

# Verify ArgoCD CLI installation
echo "Verifying ArgoCD CLI installation..."
argocd version

echo "ArgoCD installation complete. You can now access it via the NodePort service."
