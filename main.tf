terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = "ru-central1-b" # Зона доступности по умолчанию
}

provider "yandex" {
    token  = "y0_AgAAAAANhruJAATuwQAAAAD4r9GtCfNVfAtkQLyDf-36uo9fEWuYSnY"
    cloud_id  = "b1g3kq4jkid5coa26uk9"
    folder_id  = "b1gaqd9fid4ptghu9b80"
    zone = "ru-central1-b"
}

#resource "yandex_compute_instance" "vm-1" {
#  name = "terraform1"
#}

#resource "yandex_compute_instance" "vm-2" {
#  name = "terraform2"
#}
