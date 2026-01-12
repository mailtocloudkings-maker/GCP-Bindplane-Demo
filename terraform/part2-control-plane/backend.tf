terraform {
  backend "gcs" {
    bucket  = "bindplane-tf-state-bucket"
    prefix  = "bindplane/part2-control-plane"
  }
}
