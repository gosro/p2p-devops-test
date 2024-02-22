provider "google" {
  credentials = file("path/to/file/service-account.json")
  project     = var.gcp_project
  region      = var.gcp_region
}

provider "kubernetes" {
  # Assuming you're using a kubeconfig file that has the context for your GKE cluster
  config_path    = "~/.kube/config"
  config_context = "gke_p2p-test-414709_us-central1_gke-cluster"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
    config_context = "gke_p2p-test-414709_us-central1_gke-cluster"
  }
}
