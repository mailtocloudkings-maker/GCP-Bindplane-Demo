terraform {
  backend "gcs" {
    bucket  = "bindplane-tf-state-demo"
    prefix  = "bindplane/part1-db"
  }
}
