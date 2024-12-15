provider "openstack" {
  auth_url    = var.auth_url
  tenant_id   = var.project_id
  username    = var.username
  password    = var.password
  region      = var.region_name
  domain_name = var.user_domain_name
}

resource "openstack_compute_instance_v2" "efremenko_infra_tf" {
  name            = var.instance_name
  flavor_name     = var.flavor_name
  image_name      = var.image_name
  key_pair        = var.key_pair_name
  security_groups = var.security_groups

  network {
    port = openstack_networking_port_v2.port.id
  }
}

resource "openstack_networking_port_v2" "port" {
  name           = "${var.instance_name}-port"
  network_id     = var.network_id
  admin_state_up = true
}

# Дождаться доступности сервера по SSH
resource "null_resource" "wait_for_ssh" {
  depends_on = [openstack_compute_instance_v2.efremenko_infra_tf]

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.ssh_private_key_path)
      host        = openstack_compute_instance_v2.efremenko_infra_tf.access_ip_v4
    }

    inline = [
      "echo 'Server is accessible via SSH'",
    ]
  }
}

# Передать управление Ansible
resource "null_resource" "ansible_provision" {
  depends_on = [null_resource.wait_for_ssh]

  provisioner "local-exec" {
    command = <<EOT
      ansible-playbook -i ${openstack_compute_instance_v2.efremenko_infra_tf.access_ip_v4}, \
        -u ubuntu \
        --private-key=${var.ssh_private_key_path} \
        playbook.yml
    EOT
  }
}
