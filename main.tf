resource "openstack_compute_instance_v2" "my_instance" {
  name        = var.instance_name
  image_name  = var.image
  flavor_name = var.flavor
  key_pair    = var.key_name

  network {
    name = var.network_name
  }

  security_groups = [var.security_group]
}