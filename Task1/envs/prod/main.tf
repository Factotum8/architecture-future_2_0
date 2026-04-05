module "vm_module" {
  source = "../../modules/vm"

  name           = var.vm_name
  cores          = var.cores
  memory_gb      = var.memory_gb
  disk_size_gb   = var.disk_size_gb
  subnet_id      = var.subnet_id
  ssh_public_key = var.ssh_public_key
  zone           = var.zone
  image_id       = var.image_id

  boot_disk_size_gb = var.boot_disk_size_gb
  platform_id       = var.platform_id
  enable_nat        = var.enable_nat
  ssh_user          = var.ssh_user
  labels            = var.labels
}
