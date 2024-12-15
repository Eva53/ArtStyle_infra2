output "instance_ip" {
  value = openstack_compute_instance_v2.efremenko_infra_tf.access_ip_v4
  description = "The public IP address of the instance"
}

output "instance_ip_file" {
  value = openstack_compute_instance_v2.efremenko_infra_tf.access_ip_v4
  description = "The public IP address saved to a file"
}

resource "local_file" "instance_ip_output" {
  filename = "instance_ip.txt"
  content  = openstack_compute_instance_v2.efremenko_infra_tf.access_ip_v4
}
