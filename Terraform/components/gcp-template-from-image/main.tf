data "google_compute_image" "gcp-os-image" {
   family = var.imageFamily
   project = var.imageProject
}

resource "google_compute_instance_template" "gcp-os-template" {
  name        = "${var.template}-template"
  description = "This template is used to create ${var.template} server instances."

  tags = []

  labels = {
    env = "${var.template}-template"
  }

  instance_description = "${var.template}-template instances"
  machine_type         = "n1-standard-1"
  can_ip_forward       = true

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  // Create a new boot disk from an image
  disk {
    source_image = data.google_compute_image.gcp-os-image.self_link
    auto_delete  = true
    boot         = true
    type         = "PERSISTENT"
    disk_size_gb = "20"
    disk_type    = "pd-standard"
    device_name  = "${var.template}-template"
    mode         = "READ_WRITE"
  }

  network_interface {
    network    = "default"
    // subnetwork = ""
  }

  metadata = {
    // startup-script-url = ""
    foo = "bar"
  }

  service_account {
    // email  = "selvamxxx@xxxxx.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
