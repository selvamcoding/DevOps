module "container-vm" {
  source  = "terraform-google-modules/container-vm/google"
  version = "2.0.0"

  cos_image_family = "stable"

  container = {
    image="docker.io/selvamvasu/phpservermonitor:3.5.2"
    env = [
      {
        name = "MYSQL_HOST"
        value = var.dbhost
      },
      {
        name = "MYSQL_USER"
        value = "phpservermonitor"
      },
      {
        name = "MYSQL_PASSWORD"
        value = var.dbpasswd
      },
      {
        name = "MYSQL_DATABASE"
        value = "phpservermonitor"
      },
    ]
  }

  restart_policy = "Always"
}


resource "google_compute_instance" "psm" {
  project = var.project
  machine_type = var.machine_type
  name = "phpservermonitor"
  zone = "${var.region}-b"

  boot_disk {
    auto_delete = true
    initialize_params {
      image = module.container-vm.source_image
      size = 50
    }
  }

  network_interface {
    subnetwork = "projects/${var.project}/regions/${var.region}/subnetworks/default"
  }

  service_account {
    email = "selvamxxx@xxxxx.com"
    scopes = ["cloud-platform"]
  }

  tags = ["http-server"]

  metadata = {
    gce-container-declaration = module.container-vm.metadata_value
    google-logging-enabled =  "true"
  }
}

output "ipv4" {
  value = google_compute_instance.psm.network_interface.0.network_ip
}
