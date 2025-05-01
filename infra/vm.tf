data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2404-lts"
}

resource "yandex_vpc_address" "public_ip" {
  name = "kittygram-ip"
  external_ipv4_address {
    zone_id = "ru-central1-a"
  }
}

resource "yandex_compute_instance" "vm" {
  name = "kittygram-vm"
  zone = "ru-central1-a"

  resources {
    cores  = 2
    memory = 4  # 4 GB RAM
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 15  # 15 GB диск
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet.id
    security_group_ids = [yandex_vpc_security_group.sg.id]
    nat                = true
    nat_ip_address     = yandex_vpc_address.public_ip.external_ipv4_address[0].address
  }

  metadata = {
    user-data = templatefile("${path.module}/init/vm-install.yml", {})
    ssh-keys  = "ubuntu:${var.vm_ssh_pubkey}"
  }
}

resource "yandex_storage_bucket" "tf_state" {
  bucket = "kittygram-terraform-state-muxbyte93"
  acl    = "private"
}
