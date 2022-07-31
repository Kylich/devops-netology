# Домашнее задание к занятию "7.3. Основы и принцип работы Терраформ"

## Задача 1. Создадим бэкэнд в S3 (необязательно, но крайне желательно)

Если в рамках предыдущего задания у вас уже есть аккаунт AWS, то давайте продолжим знакомство со взаимодействием
терраформа и aws
- у меня нет аккаунта AWS
---

## Задача 2. Инициализируем проект и создаем воркспейсы

1. Выполните `terraform init`: будет создан локальный файл со стейтами
1. Создайте два воркспейса `stage` и `prod`
1. В уже созданный `yandex_compute_instance` добавьте зависимость типа инстанса от вокспейса, что бы в разных ворскспейсах использовались разные `instance_type`
1. Добавим `count`. Для `stage` должен создаться один экземпляр `ec2`, а для `prod` два
1. Создайте рядом еще один `yandex_compute_instance`, но теперь определите их количество при помощи `for_each`, а не `count`
1. Что бы при изменении типа инстанса не возникло ситуации, когда не будет ни одного инстанса добавьте параметр жизненного цикла `create_before_destroy = true` в один из рессурсов `yandex_compute_instance`
1. При желании поэкспериментируйте с другими параметрами и ресурсами

В виде результата работы пришлите:
* Вывод команды `terraform workspace list`

```bash
@ ~ terraform workspace list
 default
* prod
 stage
```

* Вывод команды `terraform plan` для воркспейса `prod`

```bash
@ ~ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
 + create

Terraform will perform the following actions:

 # yandex_compute_instance.yci1[0] will be created
 + resource "yandex_compute_instance" "yci1" {
     + created_at                = (known after apply)
     + folder_id                 = (known after apply)
     + fqdn                      = (known after apply)
     + hostname                  = (known after apply)
     + id                        = (known after apply)
     + metadata                  = {
         + "ssh-keys" = <<-EOT
               ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDVKDZIbpdOLn5aFsvo5ReaEJMqp96M2OxhdJsjRNVv2c5gEVUbVTWUo7zCC3rCfLuNWH1mztx6eN9lgcapB5AwbXYml6ydup19S+bITyrejGpCqCLWiJDKAtPWYSX3TwJSL/B5h56MqYgzUaLnkqDeKTXi2ewNo3hJtgnNs8T4Hm3Ip+Spdj8cuStxE/iAw+EeVmu2a05uzKEXwddZBlhVoX/lmp6gpUZDl4hREhdkLQ7Rn9ZuSYItRLJN2mPojHH/SkDBRaoh+dEURvHUEQ6trb0LvxByJ9wntSdTms8h44IMzv5+Yg+BdZEfTmil07uGPnXhKThIgUwmKOcr5nfltth52GWRBolI60qotLsGzeNhyv3LcySaijpCyNphcjTrdhQkK3ci5WHuq5WuZ9URzyLKVjzaZydV4/1Z7VzE0MOVNbbJZ+OX0ouQw7T1b23KpzqygBKAsiznbFKT7E1IgBJ7zC3IZU7pix3o5UZyDUB34lpfkMaV0GaLUxBU08= kulikov@kulikov-lubuntu
           EOT
       }
     + name                      = "terraform-0"
     + network_acceleration_type = "standard"
     + platform_id               = "standard-v1"
     + service_account_id        = (known after apply)
     + status                    = (known after apply)
     + zone                      = (known after apply)

     + boot_disk {
         + auto_delete = true
         + device_name = (known after apply)
         + disk_id     = (known after apply)
         + mode        = (known after apply)

         + initialize_params {
             + block_size  = (known after apply)
             + description = (known after apply)
             + image_id    = "capB5AwbXYml6ydup19S"
             + name        = (known after apply)
             + size        = (known after apply)
             + snapshot_id = (known after apply)
             + type        = "network-hdd"
           }
       }

     + network_interface {
         + index              = (known after apply)
         + ip_address         = (known after apply)
         + ipv4               = true
         + ipv6               = (known after apply)
         + ipv6_address       = (known after apply)
         + mac_address        = (known after apply)
         + nat                = true
         + nat_ip_address     = (known after apply)
         + nat_ip_version     = (known after apply)
         + security_group_ids = (known after apply)
         + subnet_id          = (known after apply)
       }

     + placement_policy {
         + host_affinity_rules = (known after apply)
         + placement_group_id  = (known after apply)
       }

     + resources {
         + core_fraction = 100
         + cores         = 4
         + memory        = 4
       }

     + scheduling_policy {
         + preemptible = (known after apply)
       }
   }

 # yandex_compute_instance.yci1[1] will be created
 + resource "yandex_compute_instance" "yci1" {
     + created_at                = (known after apply)
     + folder_id                 = (known after apply)
     + fqdn                      = (known after apply)
     + hostname                  = (known after apply)
     + id                        = (known after apply)
     + metadata                  = {
         + "ssh-keys" = <<-EOT
               ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDVKDZIbpdOLn5aFsvo5ReaEJMqp96M2OxhdJsjRNVv2c5gEVUbVTWUo7zCC3rCfLuNWH1mztx6eN9lgcapB5AwbXYml6ydup19S+bITyrejGpCqCLWiJDKAtPWYSX3TwJSL/B5h56MqYgzUaLnkqDeKTXi2ewNo3hJtgnNs8T4Hm3Ip+Spdj8cuStxE/iAw+EeVmu2a05uzKEXwddZBlhVoX/lmp6gpUZDl4hREhdkLQ7Rn9ZuSYItRLJN2mPojHH/SkDBRaoh+dEURvHUEQ6trb0LvxByJ9wntSdTms8h44IMzv5+Yg+BdZEfTmil07uGPnXhKThIgUwmKOcr5nfltth52GWRBolI60qotLsGzeNhyv3LcySaijpCyNphcjTrdhQkK3ci5WHuq5WuZ9URzyLKVjzaZydV4/1Z7VzE0MOVNbbJZ+OX0ouQw7T1b23KpzqygBKAsiznbFKT7E1IgBJ7zC3IZU7pix3o5UZyDUB34lpfkMaV0GaLUxBU08= kulikov@kulikov-lubuntu
           EOT
       }
     + name                      = "terraform-1"
     + network_acceleration_type = "standard"
     + platform_id               = "standard-v1"
     + service_account_id        = (known after apply)
     + status                    = (known after apply)
     + zone                      = (known after apply)

     + boot_disk {
         + auto_delete = true
         + device_name = (known after apply)
         + disk_id     = (known after apply)
         + mode        = (known after apply)

         + initialize_params {
             + block_size  = (known after apply)
             + description = (known after apply)
             + image_id    = "capB5AwbXYml6ydup19S"
             + name        = (known after apply)
             + size        = (known after apply)
             + snapshot_id = (known after apply)
             + type        = "network-hdd"
           }
       }

     + network_interface {
         + index              = (known after apply)
         + ip_address         = (known after apply)
         + ipv4               = true
         + ipv6               = (known after apply)
         + ipv6_address       = (known after apply)
         + mac_address        = (known after apply)
         + nat                = true
         + nat_ip_address     = (known after apply)
         + nat_ip_version     = (known after apply)
         + security_group_ids = (known after apply)
         + subnet_id          = (known after apply)
       }

     + placement_policy {
         + host_affinity_rules = (known after apply)
         + placement_group_id  = (known after apply)
       }

     + resources {
         + core_fraction = 100
         + cores         = 4
         + memory        = 4
       }

     + scheduling_policy {
         + preemptible = (known after apply)
       }
   }

 # yandex_compute_instance.yci2["instance-1"] will be created
 + resource "yandex_compute_instance" "yci2" {
     + created_at                = (known after apply)
     + folder_id                 = (known after apply)
     + fqdn                      = (known after apply)
     + hostname                  = (known after apply)
     + id                        = (known after apply)
     + metadata                  = {
         + "ssh-keys" = <<-EOT
               ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDVKDZIbpdOLn5aFsvo5ReaEJMqp96M2OxhdJsjRNVv2c5gEVUbVTWUo7zCC3rCfLuNWH1mztx6eN9lgcapB5AwbXYml6ydup19S+bITyrejGpCqCLWiJDKAtPWYSX3TwJSL/B5h56MqYgzUaLnkqDeKTXi2ewNo3hJtgnNs8T4Hm3Ip+Spdj8cuStxE/iAw+EeVmu2a05uzKEXwddZBlhVoX/lmp6gpUZDl4hREhdkLQ7Rn9ZuSYItRLJN2mPojHH/SkDBRaoh+dEURvHUEQ6trb0LvxByJ9wntSdTms8h44IMzv5+Yg+BdZEfTmil07uGPnXhKThIgUwmKOcr5nfltth52GWRBolI60qotLsGzeNhyv3LcySaijpCyNphcjTrdhQkK3ci5WHuq5WuZ9URzyLKVjzaZydV4/1Z7VzE0MOVNbbJZ+OX0ouQw7T1b23KpzqygBKAsiznbFKT7E1IgBJ7zC3IZU7pix3o5UZyDUB34lpfkMaV0GaLUxBU08= kulikov@kulikov-lubuntu
           EOT
       }
     + name                      = "instance-1"
     + network_acceleration_type = "standard"
     + platform_id               = "standard-v1"
     + service_account_id        = (known after apply)
     + status                    = (known after apply)
     + zone                      = (known after apply)

     + boot_disk {
         + auto_delete = true
         + device_name = (known after apply)
         + disk_id     = (known after apply)
         + mode        = (known after apply)

         + initialize_params {
             + block_size  = (known after apply)
             + description = (known after apply)
             + image_id    = "capB5AwbXYml6ydup19S"
             + name        = (known after apply)
             + size        = (known after apply)
             + snapshot_id = (known after apply)
             + type        = "network-hdd"
           }
       }

     + network_interface {
         + index              = (known after apply)
         + ip_address         = (known after apply)
         + ipv4               = true
         + ipv6               = (known after apply)
         + ipv6_address       = (known after apply)
         + mac_address        = (known after apply)
         + nat                = true
         + nat_ip_address     = (known after apply)
         + nat_ip_version     = (known after apply)
         + security_group_ids = (known after apply)
         + subnet_id          = (known after apply)
       }

     + placement_policy {
         + host_affinity_rules = (known after apply)
         + placement_group_id  = (known after apply)
       }

     + resources {
         + core_fraction = 100
         + cores         = 2
         + memory        = 2
       }

     + scheduling_policy {
         + preemptible = (known after apply)
       }
   }

 # yandex_compute_instance.yci2["instance-2"] will be created
 + resource "yandex_compute_instance" "yci2" {
     + created_at                = (known after apply)
     + folder_id                 = (known after apply)
     + fqdn                      = (known after apply)
     + hostname                  = (known after apply)
     + id                        = (known after apply)
     + metadata                  = {
         + "ssh-keys" = <<-EOT
               ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDVKDZIbpdOLn5aFsvo5ReaEJMqp96M2OxhdJsjRNVv2c5gEVUbVTWUo7zCC3rCfLuNWH1mztx6eN9lgcapB5AwbXYml6ydup19S+bITyrejGpCqCLWiJDKAtPWYSX3TwJSL/B5h56MqYgzUaLnkqDeKTXi2ewNo3hJtgnNs8T4Hm3Ip+Spdj8cuStxE/iAw+EeVmu2a05uzKEXwddZBlhVoX/lmp6gpUZDl4hREhdkLQ7Rn9ZuSYItRLJN2mPojHH/SkDBRaoh+dEURvHUEQ6trb0LvxByJ9wntSdTms8h44IMzv5+Yg+BdZEfTmil07uGPnXhKThIgUwmKOcr5nfltth52GWRBolI60qotLsGzeNhyv3LcySaijpCyNphcjTrdhQkK3ci5WHuq5WuZ9URzyLKVjzaZydV4/1Z7VzE0MOVNbbJZ+OX0ouQw7T1b23KpzqygBKAsiznbFKT7E1IgBJ7zC3IZU7pix3o5UZyDUB34lpfkMaV0GaLUxBU08= kulikov@kulikov-lubuntu
           EOT
       }
     + name                      = "instance-2"
     + network_acceleration_type = "standard"
     + platform_id               = "standard-v1"
     + service_account_id        = (known after apply)
     + status                    = (known after apply)
     + zone                      = (known after apply)

     + boot_disk {
         + auto_delete = true
         + device_name = (known after apply)
         + disk_id     = (known after apply)
         + mode        = (known after apply)

         + initialize_params {
             + block_size  = (known after apply)
             + description = (known after apply)
             + image_id    = "capB5AwbXYml6ydup19S"
             + name        = (known after apply)
             + size        = (known after apply)
             + snapshot_id = (known after apply)
             + type        = "network-hdd"
           }
       }

     + network_interface {
         + index              = (known after apply)
         + ip_address         = (known after apply)
         + ipv4               = true
         + ipv6               = (known after apply)
         + ipv6_address       = (known after apply)
         + mac_address        = (known after apply)
         + nat                = true
         + nat_ip_address     = (known after apply)
         + nat_ip_version     = (known after apply)
         + security_group_ids = (known after apply)
         + subnet_id          = (known after apply)
       }

     + placement_policy {
         + host_affinity_rules = (known after apply)
         + placement_group_id  = (known after apply)
       }

     + resources {
         + core_fraction = 100
         + cores         = 4
         + memory        = 4
       }

     + scheduling_policy {
         + preemptible = (known after apply)
       }
   }

 # yandex_vpc_network.network1 will be created
 + resource "yandex_vpc_network" "network1" {
     + created_at                = (known after apply)
     + default_security_group_id = (known after apply)
     + folder_id                 = (known after apply)
     + id                        = (known after apply)
     + labels                    = (known after apply)
     + name                      = "network1"
     + subnet_ids                = (known after apply)
   }

 # yandex_vpc_subnet.subnet1 will be created
 + resource "yandex_vpc_subnet" "subnet1" {
     + created_at     = (known after apply)
     + folder_id      = (known after apply)
     + id             = (known after apply)
     + labels         = (known after apply)
     + name           = "subnet1"
     + network_id     = (known after apply)
     + v4_cidr_blocks = [
         + "192.168.10.0/24",
       ]
     + v6_cidr_blocks = (known after apply)
     + zone           = "ru-central1-a"
   }

Plan: 6 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if
you run "terraform apply" now.

```
