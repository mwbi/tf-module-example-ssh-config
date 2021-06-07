# create ansible_inventory from template

data "template_file" "ssh_config_template" {
  template = <<EOT
%{for group in var.groups_with_floating_ips~}
%{for fip_association in group.instancesobject.floating_ip_associations.*~}
%{for host in group.instancesobject.instances.*~}
%{if host.id == fip_association.instance_id~}
Host ${host.name}
Hostname ${fip_association.floating_ip}
IdentityFile ${var.ssh_private_key}
User ${var.jumphost_user}
StrictHostKeyChecking accept-new
%{endif~}
%{endfor~}
%{endfor~}
%{endfor~}

%{for group in var.groups_without_floating_ips~}
%{for host in group.instancesobject.instances.*~}
Host ${host.name}
Hostname ${host.network[0].fixed_ip_v4}
User ${group.user_for_ansible}
IdentityFile ${var.ssh_private_key}
ProxyJump ${var.jumphost_instanceobject.instances[0].name}
StrictHostKeyChecking accept-new
%{endfor~}
%{endfor~}
EOT
}

resource "local_file" "ssh_config" {
  content         = data.template_file.ssh_config_template.rendered
  filename        = var.ssh_config_output
  file_permission = var.file_permissions
}
