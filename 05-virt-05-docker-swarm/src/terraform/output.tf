output "internal_ip_address_node001" {
  value = "${yandex_compute_instance.node001.network_interface.0.ip_address}"
}

output "external_ip_address_node001" {
  value = "${yandex_compute_instance.node001.network_interface.0.nat_ip_address}"
}

output "internal_ip_address_node002" {
  value = "${yandex_compute_instance.node002.network_interface.0.ip_address}"
}

output "external_ip_address_node002" {
  value = "${yandex_compute_instance.node002.network_interface.0.nat_ip_address}"
}

output "internal_ip_address_node003" {
  value = "${yandex_compute_instance.node003.network_interface.0.ip_address}"
}

output "external_ip_address_node003" {
  value = "${yandex_compute_instance.node003.network_interface.0.nat_ip_address}"
}

output "internal_ip_address_node004" {
  value = "${yandex_compute_instance.node004.network_interface.0.ip_address}"
}

output "external_ip_address_node004" {
  value = "${yandex_compute_instance.node004.network_interface.0.nat_ip_address}"
}

output "internal_ip_address_node005" {
  value = "${yandex_compute_instance.node005.network_interface.0.ip_address}"
}

output "external_ip_address_node005" {
  value = "${yandex_compute_instance.node005.network_interface.0.nat_ip_address}"
}

output "internal_ip_address_node006" {
  value = "${yandex_compute_instance.node006.network_interface.0.ip_address}"
}

output "external_ip_address_node006" {
  value = "${yandex_compute_instance.node006.network_interface.0.nat_ip_address}"
}
