resource "yandex_compute_instance" "vm-1" {
  name = "build"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8bu9gsckcm2351kqaq"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.terra_sub.id
    nat       = true
  }

  metadata = {
     user-data = "${file("/home/allon/lesson14/lesson14/meta.txt")}"
 #   ssh-keys = "ubuntu:${file("/home/allon/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "vm-2" {
  name = "prod"

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8bu9gsckcm2351kqaq"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.terra_sub.id
    nat       = true
  }

  metadata = {
     user-data = "${file("/home/allon/lesson14/lesson14/meta.txt")}"
#    ssh-keys = "ubuntu:${file("/home/allon/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_vpc_network" "terra" {
  name = "terra"
}

resource "yandex_vpc_subnet" "terra_sub" {
  name           = "terra_sub"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.terra.id
  v4_cidr_blocks = ["10.129.0.0/24"]
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


