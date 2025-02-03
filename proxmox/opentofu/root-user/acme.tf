resource "proxmox_virtual_environment_acme_account" "default_acme_account" {
  name      = "defaulti tmp"
  contact   = data.proxmox_virtual_environment_user.root_user.email
  directory = "https://acme-v02.api.letsencrypt.org/directory"
  tos       = "https://letsencrypt.org/documents/LE-SA-v1.4-April-3-2024.pdf"
}

