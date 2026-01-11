provider "google" {
  project = var.project_id
  region  = var.region
}

# Enable required APIs
resource "google_project_service" "apis" {
  for_each = toset([
    "compute.googleapis.com",
    "iam.googleapis.com",
    "storage.googleapis.com"
  ])
  service = each.key
}

# Terraform state bucket
resource "google_storage_bucket" "tf_state" {
  name          = var.tf_state_bucket
  location      = var.region
  force_destroy = true

  uniform_bucket_level_access = true
}

# GitHub Actions service account
resource "google_service_account" "github" {
  account_id   = "github-actions-sa"
  display_name = "GitHub Actions Terraform SA"
}

# IAM bindings
resource "google_project_iam_member" "sa_roles" {
  for_each = toset([
    "roles/compute.admin",
    "roles/storage.admin",
    "roles/iam.serviceAccountUser"
  ])

  role   = each.key
  member = "serviceAccount:${google_service_account.github.email}"
}

# Service account key
resource "google_service_account_key" "github_key" {
  service_account_id = google_service_account.github.name
}
