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

  # Enable this for debug logging
  #
  # pm_log_enable = true
  # pm_log_file   = "terraform-plugin-proxmox.log"
  # pm_debug      = true
  # pm_log_levels = {
  #   _default    = "debug"
  #   _capturelog = ""
  # }
}