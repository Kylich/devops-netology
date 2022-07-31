/*
    * AWS регион, который используется в данный момент -
    * Приватный IP ec2 инстансы -
    * Идентификатор подсети в которой создан инстанс -
*/

output "region" {
    value = yandex_compute_instance.vm-1.zone
}

output "private_ip" {
    value = yandex_compute_instance.vm-1.network_interface.0.ip_address
}

output "subnet_id" {
    value = yandex_vpc_subnet.subnet1.id
}