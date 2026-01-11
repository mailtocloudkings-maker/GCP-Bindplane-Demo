provider "google" {
  project = var.project_id
  region  = var.region
}
 
resource "google_compute_instance" "postgres" {
  name         = "bp-postgres"
  machine_type = "e2-micro"
  zone         = "us-central1-a"
 
  boot_disk {
    initialize_params {
      image = "debian-12"
      size  = 10
    }
  }
 
  network_interface {
    network = "default"
  }
 
  metadata_startup_script = <<EOF
#!/bin/bash
apt update
apt install -y postgresql
sudo -u postgres psql -c "CREATE USER bindplane WITH PASSWORD '${var.db_password}';"
sudo -u postgres psql -c "CREATE DATABASE bindplane OWNER bindplane;"
EOF
}
 
output "db_ip" {
  value = google_compute_instance.postgres.network_interface[0].network_ip
}
