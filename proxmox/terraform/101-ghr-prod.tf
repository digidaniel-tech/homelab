module "_101_ghr_prod_resource" {
  source = "../../terraform/modules/proxmox_vm"

  vm_name = "github-runner"
  vm_desc = "Responsible to run github workflows locally"
  vm_tags = "github"
  vm_iso = "local:iso/debian-12-unattended.iso"
  vm_host = var.PRX_HOST

  vm_disk_size = 32
  vm_disk_storage = var.PRX_STORAGE_NAME

  ssh_pub_key =  var.ssh_pub_key
  ssh_default_password =  var.ssh_default_password
}
