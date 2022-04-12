provider "yandex" {
  cloud_id = var.yandex_cloud_id
  zone     = var.yandex_cloud_zone
}

# Retrieves existing public image of a family.
data "yandex_compute_image" "container-optimized-image" {
  family = "container-optimized-image"
}

# Create service account.
resource "yandex_iam_service_account" "iam_sa" {
  folder_id   = var.folder_id
  name        = "terraform-netology-sa-${terraform.workspace}"
  description = "Service account to be used by Terraform"
}

# Grant permission "storage.editor" on folder "yandex-folder-id" for service account.
resource "yandex_resourcemanager_folder_iam_member" "storage-admin" {
  folder_id = var.folder_id
  role      = "storage.admin"
  member    = "serviceAccount:${yandex_iam_service_account.iam_sa.id}"
}

# Create Static Access Keys
resource "yandex_iam_service_account_static_access_key" "iam-sa-static-key" {
  service_account_id = yandex_iam_service_account.iam_sa.id
  description        = "Static access key for service account"
}

# Use keys to create bucket
resource "yandex_storage_bucket" "storage-bucket" {
  access_key = yandex_iam_service_account_static_access_key.iam-sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.iam-sa-static-key.secret_key
  bucket     = "netology-bucket-${terraform.workspace}"
  grant {
    id          = yandex_iam_service_account.iam_sa.id
    type        = "CanonicalUser"
    permissions = ["READ", "WRITE"]
  }
}

# Network.
resource "yandex_vpc_network" "vpc-network" {
  folder_id   = var.folder_id
  name        = "netology-module-network"
  description = "Netology module network"
}

# Subnets of the network.
resource "yandex_vpc_subnet" "vpc-subnet" {
  folder_id      = var.folder_id
  name           = "netology-subnet-0"
  description    = "Netology subnet 0"
  v4_cidr_blocks = ["10.100.0.0/24"]
  zone           = var.yandex_cloud_zone
  network_id     = yandex_vpc_network.vpc-network.id
}

# Declare instance.
resource "yandex_compute_instance" "instance" {
  count       = var.instance_count
  folder_id   = var.folder_id
  name        = "${var.instance_name}-${format(var.count_format, var.count_offset+count.index+1)}"
  description = var.instance_description
  platform_id = var.instance_type
  hostname    = "${var.instance_name}-${format(var.count_format, var.count_offset+count.index+1)}"
  zone        = var.yandex_cloud_zone

  resources {
    cores         = var.cores
    core_fraction = var.core_fraction
    memory        = var.memory
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.container-optimized-image.id
      type     = var.boot_disk
      size     = var.disk_size
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.vpc-subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "${var.users}:${file(var.path_to_public_key)}"
  }

  allow_stopping_for_update = true
}