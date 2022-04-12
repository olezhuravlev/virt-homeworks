# Yandex.Cloud Compute Instance Terraform module

Terraform module which creates Yandex Compute Instances in designated folder.

The created instance will be accessed via ssh-terminal connection.

## Usage

````hcl
module "yc-instance" {
  source             = "./modules/yc-compute-instance"
  yandex_cloud_id    = <YOUR YANDEX CLOUD ID>
  folder_id          = <YOUR FOLDER ID>
  path_to_public_key = "~/.ssh/id_rsa.pub"
}
````

## Requirements

| Name                                                                      | Version   |
|---------------------------------------------------------------------------|-----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | > = 0.13.1 |
| <a name="requirement_yc"></a> [yc](#requirement\_yc)                  | > = ?.??   |

## Providers

| Name                                           | Version |
|------------------------------------------------|---------|
| <a name="provider_yc"></a> [yc](#provider\_yc) | > = ?.?? |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                                      | Type     |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [yandex_compute_instance.instance](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance)                                                    | resource |
| [yandex_iam_service_account.iam_sa](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/iam_service_account)                                                | resource |
| [yandex_resourcemanager_folder_iam_member.storage-admin](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/resourcemanager_folder_iam_member)             | resource |
| [yandex_iam_service_account_static_access_key.iam-sa-static-key](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/iam_service_account_static_access_key) | resource |
| [yandex_storage_bucket.storage-bucket](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/storage_bucket)                                                  | resource |
| [yandex_vpc_network.vpc-network](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_network)                                                           | resource |
| [yandex_vpc_subnet.vpc-subnet](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet)                                                              | resource |


## Inputs

| Name                 | Description                   |   Type    |      Default      | Required |
|----------------------|-------------------------------|:---------:|:-----------------:|:--------:|
| yandex_cloud_id      | Yandex Cloud ID               | `string`  |        `-`        |   yes    |
| folder_id            | Folder ID                     | `string`  |        `-`        |   yes    |
| path_to_public_key   | Path to user's `pub`-file     | `string`  |        `-`        |   yes    |
| yandex_cloud_zone    | Yandex Cloud timezone         | `string`  | `"ru-central1-a"` |    no    |
| users                | Users to assign               | `string`  |    `"ubuntu"`     |    no    |
| instance_count       | Number of instances to create | `number`  |        `1`        |    no    |
| instance_name        | Base name of instance         | `string`  |   `"instance"`    |    no    |
| instance_description | Base Description of instance  | `string`  |   `"Instance"`    |    no    |
| instance_type        | Type of instance              | `string`  |  `"standard-v1"`  |    no    |
| cores                | Number of CPU cores           | `number`  |        `2`        |    no    |
| core_fraction        | Core fraction                 | `number`  |       `20`        |    no    |
| memory               | Memory (GB)                   | `number`  |        `2`        |    no    |
| boot_disk            | Boot Disk Type                | `string`  |  `"network-hdd"`  |    no    |
| disk_size            | Boot Disk Size (>=30GB)       | `number`  |       `30`        |    no    |

## Outputs

|      Name      | Description                 |
|:--------------:|:----------------------------|
| `external_ip`  | External IP of the instance |

## Authors

Module is maintained by [Oleg Zhuravlev](https://github.com/olezhuravlev).

## License

Apache 2 Licensed. See [LICENSE](https://www.apache.org/licenses/LICENSE-2.0.txt) for full details.
