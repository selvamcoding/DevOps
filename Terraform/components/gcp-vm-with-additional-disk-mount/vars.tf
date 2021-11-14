variable "project" {}

variable "credentials" {}

variable "region" {}

variable "zone" {}

variable "template_name" {}

variable "machine_type" {}

variable "vm_name" {}

variable "ssh_user" {}

variable "private_key" {
  default = "~/.ssh/id_rsa"
}

