data "google_compute_instance_template" "gcp_template" {
  name = var.template_name
  project = var.project
}

resource "google_compute_instance_from_template" "vm_instance" {
  name = var.vm_name
  zone = var.zone

  source_instance_template = var.template_name

  // Override vm specs
  machine_type = var.machine_type

  boot_disk {
    auto_delete = true
    initialize_params {
      image = data.google_compute_instance_template.gcp_template.disk[0].source_image
      size = var.boot_disk_size
    }
  }

  network_interface {
    network    = "default"
    subnetwork = "projects/${var.project}/regions/${var.region}/subnetworks/default"
  }
}
