terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }
}

provider "proxmox" {
  pm_api_url = var.TF_VAR_PRX_URL
  pm_api_token_id = var.TF_VAR_PRX_API_ID
  pm_api_token_secret = var.TF_VAR_PRX_API_SECRET
}