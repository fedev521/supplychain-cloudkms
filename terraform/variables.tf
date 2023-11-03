variable "billing_account" {
  description = "Billing account id."
  type        = string
  sensitive   = true
  default     = null
}

variable "project_id" {
  description = "GCP project id."
  type        = string
  default     = "prj-secure-run-001"
}

variable "key_project_id" {
  description = "The Cloud KMS project id, separate from the service project."
  type        = string
  default     = "prj-key-management-001"
}

variable "key_admin_email" {
  description = "Your Google mail address, e.g. johndoe@gmail.com"
  type        = string
  default     = "prj-key-management-001"
}

variable "machine_type" {
  description = "VM machine type in the free tier. Don't change the value."
  type        = string
  default     = "e2-micro"
}

variable "disk_type" {
  description = "Persistent disk type in the free tier. Don't change the value."
  type        = string
  default     = "pd-standard"
}

variable "region" {
  description = "GCP region where you can create free GCE instances. Don't change the value."
  type        = string
  default     = "us-east1"
}
