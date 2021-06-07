#
# Ansible inventory
#

variable "ssh_config_output" {
  description = "File name for the new file"
  default     = "example_ssh_config"
}

variable "file_permissions" {
  description = "Permissions for the new file"
  default     = "0644"
}

variable "groups_with_floating_ips" {
  description = "Instance objects created using the create_instance_with_floating_ip module"
  type        = list
}

variable "groups_without_floating_ips" {
  description = "Instance objects created using the terraform-module-create_instance_without_floating_ip module"
  type        = list
}

variable "jumphost_user" {
  description = "Which user to use for the jumphost"
}

variable "jumphost_instanceobject" {
  description = "The instance object of the jumphost, to get the floating IP"
}

variable "ssh_private_key" {
  description = "The path to the SSH key to use for authentication"
}
