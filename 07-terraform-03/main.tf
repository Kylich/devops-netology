terraform {
    required_providers {
        yandex = {
        source = "yandex-cloud/yandex"
        }
    }
    required_version = ">= 0.13"
}

provider "yandex" {
    token     = "${var.oauth_token}"
    cloud_id  = "${var.cloud_id}"
    folder_id = "${var.folder_id}"
    zone      = "ru-central1-a"
}

resource "yandex_compute_instance" "yci1" {
  name  = "terraform-${count.index}"
  count = local.ws_count[terraform.workspace]

  resources {
    cores  = local.yci_CPU[terraform.workspace]
    memory = local.yci_RAM[terraform.workspace]
  }

  boot_disk {
    initialize_params {
      image_id = "${var.image_id}"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "yci2" {
  for_each = local.instance_names
  name     = each.key

  resources {
    cores  = each.value
    memory = each.value
  }

  boot_disk {
    initialize_params {
      image_id = "${var.image_id}"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  lifecycle {
    create_before_destroy = true
   }
}

resource "yandex_vpc_network" "network1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

locals {
  yci_CPU  = {
    stage = 2
    prod  = 4
  }

  yci_RAM = {
    stage = 2
    prod  = 4
  }

  ws_count  = {
    stage = 1
    prod  = 2
  }

  instance_names = {
    "instance-1" = 2
    "instance-2" = 4
  }
}
