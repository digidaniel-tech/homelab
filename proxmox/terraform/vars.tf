variable "PRX_HOST" {
  type = string
}

variable "PRX_URL" {
  type = string
}

variable "PRX_API_ID" {
  type = string
}

variable "PRX_API_SECRET" {
  type = string
}

variable "PRX_ISO_NAME" {
  type = string
  default = "local:iso/debian-12-unattended.iso"
}

variable "PRX_STORAGE_NAME" {
  type = string
  default = "SSD500"
}

variable "PRX_VM_COUNT" {
  type = number
  default = 0
}

variable "PRX_VM_ID" {
  type = number
  default = 0
}

variable "PRX_VM_NAME" {
  type = string
  default = "debian"
}

variable "PRX_VM_TAGS" {
  type = string
  default = ""
}

variable "ssh_default_password" {
  type = string
}

variable "ssh_private_key_path" {
  description = "Path to the SSH private key"
}