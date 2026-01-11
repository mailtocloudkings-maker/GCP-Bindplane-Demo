provider "google" {
  project = var.project_id
  region  = var.region
}

data "terraform_remote_state" "cp" {
  backend = "gcs"
  config = {
    bucket = "bindplane-tf-state-demo"
    prefix = "bindplane/part2-control-plane"
  }
}

resource "google_compute_instance" "agent" {
  name         = "bp-agent"
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
curl -sSL https://observiq.com/install-agent.sh | bash

observiq-agent register \
  --endpoint http://${data.terraform_remote_state.cp.outputs.control_plane_ip}:3001 \
  --api-key ${data.terraform_remote_state.cp.outputs.bindplane_api_key}
EOF
}
