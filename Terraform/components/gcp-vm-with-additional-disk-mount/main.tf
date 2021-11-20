module "vm-additional-disk" {
  source = "../../modules/gcp_instance_from_template"
  vm_name = var.vm_name
  project = var.project
  region = var.region
  zone = var.zone
  template_name = var.template_name
  machine_type = var.machine_type
  boot_disk_size = "30"
}

resource "google_compute_disk" "data" {
  name = "${var.vm_name}-data"
  type = var.addtional_disk_type
  zone = var.zone
  size = var.additional_disk_size
}

resource "google_compute_attached_disk" "attach_ssd" {
  disk = google_compute_disk.data.self_link
  instance = module.vm-additional-disk.vm_self_link
}

output "ipaddr" {
  value = module.vm-additional-disk.vm_ip
}

resource "null_resource" "remote_ssh" {

  connection {
    host        = module.vm-additional-disk.vm_ip
    type        = "ssh"
    user        = var.ssh_user
    timeout     = "300s"
    private_key = file(var.private_key)
  }

  provisioner "local-exec" {
    command = "sleep 90"
  }

  provisioner "file" {
    source      =  "../../scripts/format_mount_disk.sh"
    destination = "/tmp/format_mount_disk.sh"
  }

  provisioner "remote-exec" {
    inline = [
            "sudo bash /tmp/format_mount_disk.sh",
            "rm -f /tmp/format_mount_disk.sh"
    ]
  }

  depends_on = [module.vm-additional-disk]
}
