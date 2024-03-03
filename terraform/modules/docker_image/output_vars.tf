output "image_id" {
  description = "The ID of the created Docker image"
  value       = docker_image.image.image_id
}