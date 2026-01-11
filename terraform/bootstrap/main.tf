############################################
# Provider
############################################
provider "google" {
  project = var.project_id
  region  = var.region
}

############################################
# Enable Required GCP APIs
############################################
resource "google_project_service" "required_apis" {
  for_each = toset([
    "compute.googleapis.com",
    "iam.googleapis.com",
    "storage.googleapis.com",
    "sqladmin.googleapis.com",        
    "serviceusage.googleapis.com"
  ])

  service = each.key
  disable_on_destroy = false
}

############################################
# GCS Bucket for Terraform Remote State
############################################
resource "google_storage_bucket" "tf_state" {
  name          = var.tf_state_bucket
  location      = var.region
  force_destroy = true

  uniform_bucket_level_access = true
}

############################################
# GitHub Actions Service Account
############################################
resource "google_service_account" "github" {
  account_id   = "github-actions-sa"
  display_name = "GitHub Actions Terraform Service Account"
}

############################################
# IAM Roles for GitHub Actions Service Account
############################################
resource "google_project_iam_member" "github_sa_roles" {
  for_each = toset([
    "roles/compute.admin",
    "roles/storage.admin",
    "roles/iam.serviceAccountUser",
    "roles/cloudsql.admin",                
    "roles/serviceusage.serviceUsageAdmin" 
  ])

  role   = each.key
  member = "serviceAccount:${google_service_account.github.email}"
}

############################################
# Service Account Key (Used in GitHub Secrets)
############################################
resource "google_service_account_key" "github_key" {
  service_account_id = google_service_account.github.name
}
