module "template-instance-example" {
  source = "../../modules/gcp_instance_from_template"
  vm_name = var.vm_name
  project = var.project
  region = var.region
  zone = var.zone
  template_name = var.template_name
  machine_type = var.machine_type
}

output "ipaddr" {
  value = module.template-instance-example.vm_ip
}

