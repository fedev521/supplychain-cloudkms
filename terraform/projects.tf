module "project" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/project?ref=v27.0.0"

  name            = var.project_id
  billing_account = var.billing_account

  services = [
    "artifactregistry.googleapis.com",
    "run.googleapis.com",
    "cloudbuild.googleapis.com",
  ]

  project_create = false
  skip_delete    = true
}

module "key_project" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/project?ref=v27.0.0"

  name            = var.key_project_id
  billing_account = var.billing_account

  services = [
    "cloudkms.googleapis.com"
  ]

  iam = {
    "roles/cloudkms.admin" = ["user:${var.key_admin_email}"]
  }

  project_create = false
  skip_delete    = true
}
