terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.70.1"
    }

    null = {
      source = "hashicorp/null"
      version = "3.2.3"
    }
  }

  required_version = "1.9.0"
}

provider "proxmox" {
  endpoint = "https://gryffindor.home.wollbro.se:8006/"
  username = "root@pam"
  password = "password"
  insecure = true

  ssh {
    agent = true
    username = "root"
    private_key = file("~/.ssh/id_rsa")
  }
}
