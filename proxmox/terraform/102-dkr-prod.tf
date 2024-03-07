module "_102_dkr_prod_resource" {
  source = "../../terraform/modules/proxmox_vm"

  vm_name = "Docker"
  vm_desc = "Docker instance to run containers from"
  vm_tags = "docker;proxy"

  vm_iso = "local:iso/debian-12-unattended.iso"
  vm_host = var.PRX_HOST

  vm_ram = 4096

  vm_disk_size = 50
  vm_disk_storage = var.PRX_STORAGE_NAME

  ssh_pub_key =  var.ssh_pub_key
  ssh_default_password =  var.ssh_default_password
}