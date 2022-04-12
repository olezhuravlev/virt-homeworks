# To expose public IP-address.
output "external_ip" {
  value = yandex_compute_instance.container-optimized-instance.network_interface.0.nat_ip_address
}
