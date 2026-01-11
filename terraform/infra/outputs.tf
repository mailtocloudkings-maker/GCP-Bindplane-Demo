output "vm_name" {
  value = google_compute_instance.bindplane_agent_vm.name
}

output "vm_internal_ip" {
  value = google_compute_instance.bindplane_agent_vm.network_interface[0].network_ip
}
