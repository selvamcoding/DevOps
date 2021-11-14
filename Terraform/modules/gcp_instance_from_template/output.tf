output "vm_ip" {
  value = google_compute_instance_from_template.vm_instance.network_interface.0.network_ip
}

output "vm_self_link" {
  value = google_compute_instance_from_template.vm_instance.self_link
}
