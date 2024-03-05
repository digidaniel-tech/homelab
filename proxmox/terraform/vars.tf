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

variable "PRX_STORAGE_NAME" {
  type = string
  default = "SSD500"
}

variable "ssh_default_password" {
  type = string
  default = ""
  sensitive = true
}

variable "ssh_pub_key" {
  type = string
  default = ""
}