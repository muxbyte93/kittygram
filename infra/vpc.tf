resource "yandex_vpc_network" "vpc" {
  name        = "kittygram-network"
  description = "VPC for Kittygram"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "kittygram-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = ["10.0.0.0/24"]  # подсеть для ВМ
}

resource "yandex_vpc_security_group" "sg" {
  name        = "kittygram-sg"
  network_id  = yandex_vpc_network.vpc.id
  description = "Security group for Kittygram VM"

  ingress {                      # Правило для SSH
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
    description    = "Allow SSH from anywhere"
  }
  ingress {                      # Правило для веб-приложения (порт 80)
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
    description    = "Allow HTTP from anywhere"
  }
  egress {                       # Разрешить весь исходящий трафик
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    description    = "Allow all outbound traffic"
  }
}
