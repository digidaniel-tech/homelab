resource "docker_image" "image" {
  name          = var.image_name
  keep_locally  = false
}