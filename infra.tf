resource "yandex_compute_instance" "build" {
  name = "terraform1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd87va5cc00gaq2f5qfb"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.default-ru-central1-b.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "prod" {
  name = "terraform2"

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd87va5cc00gaq2f5qfb"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.default-ru-central1-b.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.ip_address
}

output "internal_ip_address_vm_2" {
  value = yandex_compute_instance.vm-2.network_interface.0.ip_address
}

output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}

output "external_ip_address_vm_2" {
  value = yandex_compute_instance.vm-2.network_interface.0.nat_ip_address
}








#data "yandex_compute_image" "ubuntu_image" {
#  family = "ubuntu-2004-lts"
#}
 
#resource "yandex_compute_instance" "build" {
#  name = "build"
 
#  resources {
#    cores  = 2
#    memory = 2
#  }
 
#  boot_disk {
#    initialize_params {
#      image_id = data.yandex_compute_image.ubuntu_image.id
#    }
#  }
 
#  network_interface {
 #   subnet_id = yandex_vpc_subnet.default-ru-central1-b.id
#    nat       = true
#  }
 
#  metadata = {
#    user-data = "${file("./meta.yml")}"
#  }
 
#}
 
#resource "yandex_vpc_network" "default-ru-central1-b" {
#  name = "default-ru-central1-b"
#}
 
#resource "yandex_vpc_subnet" "default-ru-central1-b" {
#  name           = "default-ru-central1-b"
#  zone           = "ru-central1-b"
#  network_id     = yandex_vpc_network.default-ru-central1-b.id
#  v4_cidr_blocks = ["192.168.15.0/24"]
#}