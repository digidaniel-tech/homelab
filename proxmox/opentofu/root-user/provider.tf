terraform {
  required_version = "1.9.0"

  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.70.1"
    }
  }
}

provider "proxmox" {
  endpoint = var.endpoint

  username = "root@pam"
  password = var.password
  
  insecure = true
  tmp_dir  = "/var/tmp"
}

