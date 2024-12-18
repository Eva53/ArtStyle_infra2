resource "openstack_compute_instance_v2" "efremenko_infra_tf" {
  name        = var.instance_name
  image_name  = var.image
  flavor_name = var.flavor
  key_pair    = var.key_name

  network {
    name = var.network_name
  }

  block_device {
    source_type           = "image"                        # �������� - �����
    destination_type      = "volume"                       # ���������� - ���� (volume)
    uuid                  = "253a6ce9-fd9d-4a14-bbac-097a6eb8fb10"  # UUID ������
    volume_size           = 20                             # ������ ����� � ��
    boot_index            = 0                              # ����������� ����
    delete_on_termination = true
  }

  security_groups = [var.security_group]
}

output "instance_ip" { value = openstack_compute_instance_v2.efremenko_infra_tf.access_ip_v4 }