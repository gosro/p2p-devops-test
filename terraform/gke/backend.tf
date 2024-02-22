terraform {
  backend "gcs" {
    bucket  = "bucket-name"
    prefix  = "terraform/state"
    credentials = "path/to/file/service-account.json"
  }
}
