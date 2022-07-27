terraform {
    required_providers {
        yandex = {
        source = "yandex-cloud/yandex"
        }
    }
    required_version = ">= 0.13"
}

provider "yandex" {
    token     = "<OAuth>"
    cloud_id  = "b1g4drro47rs6n3fu4q7"
    folder_id = "b1gsdofpv4kr8inq06a4"
    zone      = "ru-central1-a"
}
