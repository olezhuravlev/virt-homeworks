# Base Terraform definition.
terraform {
  required_providers {
    yandex = {
      source = "terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex"
    }
  }
}

# Define provider.
provider "yandex" {
  cloud_id = var.yandex-cloud-id
  zone     = var.yandex-cloud-zone
}

# Create folder.
resource "yandex_resourcemanager_folder" "netology-folder" {
  cloud_id    = var.yandex-cloud-id
  name        = "netology-folder-atlantis-server"
  description = "Folder of Atlantis Server"
}

# Network.
resource "yandex_vpc_network" "netology-network" {
  folder_id   = yandex_resourcemanager_folder.netology-folder.id
  name        = "netology-network"
  description = "Netology network"
}

# Subnets of the network.
resource "yandex_vpc_subnet" "netology-subnet" {
  folder_id      = yandex_resourcemanager_folder.netology-folder.id
  name           = "netology-subnet-0"
  description    = "Netology subnet 0"
  v4_cidr_blocks = ["10.100.0.0/24"]
  zone           = var.yandex-cloud-zone
  network_id     = yandex_vpc_network.netology-network.id
}

# Retrieves existing public image of a family.
data "yandex_compute_image" "container-optimized-image" {
  family = "container-optimized-image"
}

# Declare instance for Atlantis server.
resource "yandex_compute_instance" "container-optimized-instance" {
  name        = "atlantis-server"
  description = "Atlantis Server"
  platform_id = "standard-v1"
  hostname    = "atlantis-server.netology.cloud"
  zone        = "ru-central1-a"
  folder_id   = yandex_resourcemanager_folder.netology-folder.id

  resources {
    cores         = 2
    core_fraction = 20
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.container-optimized-image.id
      type     = "network-hdd"
      size     = 30
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.netology-subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys                     = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    docker-container-declaration = file("./specification.yaml")
  }

  provisioner "file" {
    connection {
      host = yandex_compute_instance.container-optimized-instance.network_interface.0.nat_ip_address
      type = "ssh"
      user = "ubuntu"
    }
    destination = "/home/ubuntu/atlantis-server-config"
    source      = "./configs"
  }

  allow_stopping_for_update = true
}
