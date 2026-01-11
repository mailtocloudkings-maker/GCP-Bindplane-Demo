resource "google_compute_firewall" "allow_ssh_bindplane" {
  name    = "allow-ssh-bindplane6"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "3001"]
  }

  source_ranges = ["0.0.0.0/0"]
}
