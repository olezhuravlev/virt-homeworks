resource "yandex_compute_instance" "node005" {
  name                      = "node005"
  zone                      = "ru-central1-a"
  hostname                  = "node005.netology.yc"
  allow_stopping_for_update = true

  resources {
    cores  = 4
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id    = "${var.centos-7-base}"
      name        = "root-node005"
      type        = "network-nvme"
      size        = "15"
    }
  }

  network_interface {
    subnet_id  = "e9b621schggu7eeaqjrc"
    nat        = true
    ip_address = "192.168.101.15"
  }

  metadata = {
    ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
  }
}
