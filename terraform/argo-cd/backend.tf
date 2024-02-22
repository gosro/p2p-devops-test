terraform {
  backend "gcs" {
    bucket  = "p2p-test"
    prefix  = "terraform-argo/state"
    credentials = "path/to/file/service-account.json"
  }
}