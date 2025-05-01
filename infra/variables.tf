variable "yc_cloud_id" {
  type = string
  description = "Идентификатор облака в Yandex Cloud"
}

variable "yc_folder_id" {
  type = string
  description = "Идентификатор каталога в Yandex Cloud"
}

variable "vm_ssh_pubkey" {
  type        = string
  description = "Публичный SSH-ключ для пользователя VM"
}
