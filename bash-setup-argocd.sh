#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "🔄 Updating system packages..."
sudo apt-get update -y
sudo apt-get upgrade -y

echo "📦 Installing required packages..."
sudo apt-get install -y curl apt-transport-https

echo "🚀 Installing Helm..."
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
helm version

echo "📁 Adding Helm repositories..."
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add argo https://argoproj.github.io/argo-helm

echo "🔍 Checking Kubernetes nodes..."
kubectl get nodes

echo "📂 Creating Argo CD namespace..."
kubectl create namespace argocd

echo "📥 Installing Argo CD..."
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "⏳ Waiting for Argo CD pods to be ready..."
kubectl wait --namespace argocd --for=condition=Ready pods --all --timeout=300s

echo "📋 Verifying Argo CD installation..."
kubectl get pods -n argocd
kubectl get ns
kubectl get all -n argocd

echo "🌐 Exposing Argo CD server via NodePort..."
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'
kubectl get svc argocd-server -n argocd

echo "🔐 Retrieving Argo CD admin password..."
ARGOCD_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
echo "✅ Argo CD admin password: $ARGOCD_PASSWORD"

echo "📲 Logging into Argo CD CLI..."
ARGOCD_SERVER=$(kubectl get svc argocd-server -n argocd -o jsonpath="{.spec.clusterIP}")
argocd login $ARGOCD_SERVER --username admin --password $ARGOCD_PASSWORD --insecure

echo "🔑 Prompting to update Argo CD admin password..."
argocd account update-password

echo "🎉 Setup complete!"
