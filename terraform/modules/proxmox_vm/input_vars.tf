variable "vm_count" {
  description = "The amount of the VM instaces"
  type = number
  default = 1
}

variable "vm_id" {
  description = "The id of the VM"
  type = string
  nullable = true
  default = null
}

variable "vm_name" {
  description = "The name of the VM"
  type = string
}

variable "vm_desc" {
  description = "The description of the VM"
  type = string
}

variable "vm_tags" {
  description = "The tags for the VM"
  type = string
}

variable "vm_bios" {
  description = "The bios the VM will run on"
  type = string
  default = "seabios"
}

variable "vm_iso" {
  description = "The ISO that the VM should run"
  type = string
}

variable "vm_host" {
  description = "The host that the VM should run on"
  type = string
}

variable "vm_cores" {
  description = "The numer of CPU cores that the VM should run on"
  type = number
  default = 2
}

variable "vm_ram" {
  description = "The amount of RAM that the VM should run on"
  type = number
  default = 2048
}

variable "vm_disk_size" {
  description = "The size of the disk that the VM should run on"
  type = number
}

variable "vm_disk_storage" {
  description = "The location of the disk that the VM should run on"
  type = string
  default = "local-lvm"
}

variable "ssh_pub_key" {
  description = "The public ssh key that will be used to access vm"
  type = string
  default = ""
}

variable "ssh_default_password" {
  description = "The default password that is used to ssh into VM"
  type = string
  default = ""
}