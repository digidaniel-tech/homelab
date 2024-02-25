terraform {
  backend "s3" {}

  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }
}

provider "proxmox" {
  pm_api_url = var.PRX_URL
  pm_api_token_id = var.PRX_API_ID
  pm_api_token_secret = var.PRX_API_SECRET
}