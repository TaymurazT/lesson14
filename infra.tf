data "yandex_compute_image" "ubuntu_image" {
  family = "ubuntu-2004-lts"
}
 
resource "yandex_compute_instance" "build" {
  name = "build"
 
  resources {
    cores  = 2
    memory = 2
  }
 
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_image.id
    }
  }
 
#  network_interface {
 #   subnet_id = yandex_vpc_subnet.default-ru-central1-b.id
#    nat       = true
#  }
 
  metadata = {
    user-data = "${file("./meta.yml")}"
  }
 
}
 
#resource "yandex_vpc_network" "default-ru-central1-b" {
#  name = "default-ru-central1-b"
#}
 
#resource "yandex_vpc_subnet" "default-ru-central1-b" {
#  name           = "default-ru-central1-b"
#  zone           = "ru-central1-b"
#  network_id     = yandex_vpc_network.default-ru-central1-b.id
#  v4_cidr_blocks = ["192.168.15.0/24"]
#}