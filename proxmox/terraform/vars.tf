variable "TF_VAR_PRX_HOST" {
  type = string
}

variable "TF_VAR_PRX_URL" {
  type = string
}

variable "TF_VAR_PRX_API_ID" {
  type = string
}

variable "TF_VAR_PRX_API_SECRET" {
  type = string
}

variable "TF_VAR_PRX_ISO_NAME" {
  type = string
  default = "local:iso/debian-12-unattended.iso"
}

variable "TF_VAR_PRX_STORAGE_NAME" {
  type = string
  default = "SSD500"
}

variable "TF_VAR_PRX_VM_NAME" {
  type = string
  default = "debian"
}

variable "TF_VAR_PRX_VM_TAGS" {
  type = string
  default = ""
}