# locals {
#   container_image = "run-hello"
#   container_tag   = "v1.0.1"
# }

# module "cloud_run_service" {
#   source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/cloud-run?ref=v27.0.0"

#   project_id = module.project.project_id
#   region     = var.region

#   name = "svc-${local.container_image}-01"
#   containers = {
#     hello = {
#       image = "${module.docker_artifact_registry.image_path}/${local.container_image}:${local.container_tag}"
#     }
#   }
#   service_account_create = true
# }
