module "docker_artifact_registry" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/artifact-registry?ref=v27.0.0"

  project_id = module.project.project_id
  location   = var.region

  name = "arr-docker-hello-01"
}
