terraform {
  required_version = "1.1.7"

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
