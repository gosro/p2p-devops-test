
# P2P DevOps Test Project

This repository contains the infrastructure and application code for deploying a web application using Kubernetes. It's managed through ArgoCD for GitOps, configured with Tanka and Jsonnet for Kubernetes resources, and provisioned using Terraform.

## Structure

- **`/argocd/applications`**: ArgoCD Application definitions for continuous deployment.
- **`/helm/mywebapp`**: Helm chart for the web application.
- **`/kubernetes/configs`**: Raw Kubernetes manifests for base infrastructure like namespaces and secrets.
- **`/my-k8s-configs`**: Kubernetes configurations using Tanka and Jsonnet.
- **`/terraform`**: Terraform configurations for provisioning infrastructure on Google Cloud and setting up ArgoCD.
- **`Dockerfile`**: Dockerfile for building the web application's container image.
- **`main.go`**: The main Go application source file.

## Prerequisites

To deploy this project, ensure you have the following installed:

- Access to a Kubernetes cluster
- `kubectl` configured for your cluster
- Terraform
- Helm

## Getting Started

### Deploying with Terraform

1. **Initialize Terraform**

   Navigate to the `/terraform/gke` directory:

   ```sh
   terraform init
   terraform apply
   ```

2. **Deploy ArgoCD**

   Use the Terraform module in `/terraform/argo-cd`:

   ```sh
   terraform apply
   ```

### Deploying Helm Chart

Deploy the Helm chart located in `/helm/mywebapp`:

```sh
helm install mywebapp ./helm/mywebapp
```

### Configuring ArgoCD

Apply the ArgoCD Application manifests to your cluster:

```sh
kubectl apply -f /argocd/applications
```

### Kubernetes Configurations

Apply the raw Kubernetes manifests for base infrastructure setup:

```sh
kubectl apply -f /kubernetes/configs
```

### Tanka Configurations

To apply configurations managed by Tanka, navigate to `/my-k8s-configs` and use `tk export` followed by `tk apply` for the respective environments. The `tk export` command prepares the Kubernetes manifests from Jsonnet files, which can then be managed by ArgoCD for deployment:

```sh
tk export /my-k8s-configs/environments/default /path/to/output/directory
# Followed by applying or managing the output with ArgoCD
```

### Continuous Deployment with ArgoCD

After setting up your infrastructure with Terraform and deploying your applications with Helm, ArgoCD automates the deployment process by syncing the state of your Kubernetes resources with the configurations defined in your Git repository. Ensure that `tk export` is executed whenever Jsonnet files are updated to reflect changes in ArgoCD-managed applications.

## Development

For local development, build the Docker container:

```sh
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t us-central1-docker.pkg.dev/p2p-test-414709/p2p-test/webapp:latest --push .
```

Run the Go application locally:

```sh
go run main.go
```
