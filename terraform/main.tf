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

resource "yandex_compute_instance" "vm-1" {
    name = "terraform1"

    resources {
        cores  = 2
        memory = 2
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

resource "yandex_vpc_network" "network1" {
    name = "network1"
}

resource "yandex_vpc_subnet" "subnet1" {
    name           = "subnet1"
    zone           = "ru-central1-a"
    network_id     = yandex_vpc_network.network1.id
    v4_cidr_blocks = ["192.168.10.0/24"]
}