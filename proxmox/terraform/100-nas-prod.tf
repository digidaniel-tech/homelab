module "_100_nas_prod_resource" {
  source = "../../terraform/modules/proxmox_vm"

  vm_name = "Truenas"
  vm_desc = "Handles network storage"
  vm_tags = "nas"
  vm_iso = "local:iso/TrueNAS-SCALE-23.10.1.3.iso"
  vm_host = var.PRX_HOST

  vm_ram = 6144
  vm_disk_size = 30

  ssh_pub_key =  var.ssh_pub_key
  ssh_default_password =  var.ssh_default_password
}