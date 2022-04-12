# Instance settings.
variable yandex_cloud_id { }
variable folder_id { }
variable path_to_public_key { }
variable yandex_cloud_zone { default = "ru-central1-a" }
variable users { default = "ubuntu" }

variable instance_count { default = 1 }
variable instance_name { default = "instance" }
variable instance_description { default = "Instance" }
variable instance_type { default = "standard-v1" }

# VM settings.
variable cores { default = 2 }
variable core_fraction { default = 20 }
variable memory { default = 2 }
variable boot_disk { default = "network-hdd" }
variable disk_size {
  default = 30
  validation {
    condition = var.disk_size >= 30
    error_message = "Disk size must be not less than 30Gb!"
  }
}

# Service variables.
#start numbering from X+1 (e.g. name-1 if '0', name-3 if '2', etc.)
variable count_offset { default = 0 }
#server number format (-1, -2, etc.)
variable count_format { default = "%01d" }