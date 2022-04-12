# To expose public IP-address.
output "external_ip" {
  value = yandex_compute_instance.instance[0].network_interface.0.nat_ip_address
}
