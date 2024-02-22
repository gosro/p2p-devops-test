provider "google" {
  credentials = file(var.credentials_file_path)
  project     = var.project_id
  region      = "us-central1"
}

resource "google_container_cluster" "gke_cluster" {
  name     = "gke-cluster"
  location = "us-central1"

  remove_default_node_pool = true
  initial_node_count = 1

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "primary_pool" {
  name       = "primary-node-pool"
  location   = "us-central1"
  cluster    = google_container_cluster.gke_cluster.name
  node_count = 1

  node_config {
    preemptible  = false
    machine_type = "e2-medium"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

output "cluster_name" {
  value = google_container_cluster.gke_cluster.name
}

output "cluster_location" {
  value = google_container_cluster.gke_cluster.location
}

output "cluster_endpoint" {
  value = google_container_cluster.gke_cluster.endpoint
}
