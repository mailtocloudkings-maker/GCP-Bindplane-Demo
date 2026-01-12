terraform {
  backend "gcs" {
    bucket  = "bindplane-tf-state-bucket"
    prefix  = "bindplane/part1-db"
  }
}
