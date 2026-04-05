resource "yandex_compute_disk" "attached" {
  name   = "${var.name}-data"
  size   = var.disk_size_gb
  zone   = var.zone
  labels = var.labels
}

resource "yandex_compute_instance" "this" {
  name        = var.name
  platform_id = var.platform_id
  zone        = var.zone

  resources {
    cores  = var.cores
    memory = var.memory_gb
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = var.boot_disk_size_gb
    }
  }

  secondary_disk {
    disk_id = yandex_compute_disk.attached.id
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = var.enable_nat
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${var.ssh_public_key}"
  }

  labels = var.labels
}
