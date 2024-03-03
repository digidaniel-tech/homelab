variable "container_disabled" {
  description = "Disable the Docker containers"
  type = bool
  default = false
}

variable "container_name" {
  description = "The name of the Docker container"
  type = string
}

variable "container_image" {
  description = "The Docker image for the container"
  type = string
}

variable "container_restart" {
  description = "The name of the Docker container"
  type = string
  default = "unless-stopped"
}

variable "security_opts" {
  description = "A map of security options"
  type        = set(string)
  default     = []
}

variable "label_mappings" {
  description = "A map of labels"
  type        = map(string)
  default     = {}
}

variable "container_env" {
  description = "A map of environment variables"
  type        = set(string)
  default     = []
}

variable "volume_mappings" {
  description = "List of port mappings"
  type = list(object({
    container_path = optional(string)
    host_path = optional(string)
    read_only = optional(bool)
    volume_name = optional(string)
    from_container = optional(string)
  }))
}

variable "port_mappings" {
  description = "List of port mappings"
  type        = list(object({
    internal  = number
    external  = optional(number)
    ip        = optional(string)
    protocol  = optional(string)
  }))
}

variable "network_configurations" {
  description = "List of networks"
  type = list(object({
    name = string
  }))
  default = []
}

variable "copy_files" {
  description = "List of files to upload to container"
  type = list(object({
    file = string
    source = optional(string)
  }))
  default = []
}

variable "container_commands" {
  description = "A map of commands"
  type = list(string)
  default = []
}