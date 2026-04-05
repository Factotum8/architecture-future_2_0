# Замените на значения из консоли Yandex Cloud или: yc config list
cloud_id  = "b1g_replace_with_cloud_id"
folder_id = "b1g_replace_with_folder_id"
zone      = "ru-central1-a"

vm_name = "future-dev-vm"

cores        = 2
memory_gb    = 4
disk_size_gb = 20

boot_disk_size_gb = 20

subnet_id = "e9l_replace_with_subnet_id"
image_id  = "fd8_replace_with_image_id"

ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIReplaceWithYourPublicKey"

enable_nat = true

labels = {
  environment = "dev"
  project     = "future-2-0"
}
