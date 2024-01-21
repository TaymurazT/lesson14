terraform {
#  required_version = "1.1.7"

  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.105.0"
    }
  }
}

provider "yandex" {
    token  = "y0_AgAAAAANhruJAATuwQAAAAD4r9GtCfNVfAtkQLyDf-36uo9fEWuYSnY"
    cloud_id  = "b1g3kq4jkid5coa26uk9"
    folder_id  = "b1gaqd9fid4ptghu9b80"
    zone = "ru-central1-b"
}

resource "yandex_compute_instance" "lesson14" {
  name = "terraform1"
}

resource "yandex_compute_instance" "vm-1" {
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
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "vm-2" {
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
    subnet_id = yandex_vpc_subnet.subnet-1.id
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