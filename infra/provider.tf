terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.84.0"
    }
  }
  backend "s3" {
    endpoints = { 
      s3 = "https://storage.yandexcloud.net" 
    }
    bucket = "kittygram-terraform-state-muxbyte93"
    key    = "global/terraform.tfstate"
    region = "ru-central1"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

provider "yandex" {
  cloud_id  = var.yc_cloud_id       # ID облака Yandex Cloud
  folder_id = var.yc_folder_id      # ID каталога внутри облака
  zone      = "ru-central1-a"       # Зона по умолчанию
  service_account_key_file = "authorized_key.json"  # Используем сервисный аккаунт (ключ из JSON)
}
