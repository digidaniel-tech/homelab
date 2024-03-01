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

variable "ssh_default_password" {
  type = string
}

variable "ssh_pub_key" {
  type = string
}