output "artifact_registry_repository" {
  value = module.docker_artifact_registry.image_path
}

output "cosign_key" {
  value = module.kms.keys["key-cosign"].id
}

# output "service_url" {
#   value = module.cloud_run_service.service.status[0].url
# }
