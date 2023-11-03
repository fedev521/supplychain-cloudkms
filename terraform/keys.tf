module "kms" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/kms?ref=v27.0.0"

  project_id = var.key_project_id
  keyring = {
    name     = "kr-02"
    location = var.region
  }
  keys = {
    key-cosign = {
      purpose = "ASYMMETRIC_SIGN"
      version_template = {
        algorithm = "RSA_SIGN_PSS_3072_SHA256"
      }
    }
  }
}
