# Secure Software Supply Chain Demo

Build a container image, produce a SBOM, scan for vulnerabilities, sign that
container image with keys stored in Cloud KMS on Google Cloud. Then, deploy the
container to Cloud Run.

- [Prerequisites](#prerequisites)
- [How To Run](#how-to-run)
  - [1. Create Resources on GCP](#1-create-resources-on-gcp)
  - [2. Run CI](#2-run-ci)
  - [3. Fix the Vulnerability](#3-fix-the-vulnerability)
  - [4. Run CD](#4-run-cd)


## Prerequisites

Tools:

- gcloud
- docker
- terraform
- [https://github.com/sigstore/cosign](cosign)
- [https://github.com/anchore/syft](syft)
- [https://github.com/anchore/grype](grype)

## How To Run

### 1. Create Resources on GCP

Basically:

```bash
cd terraform
terraform init
terraform apply
```

But before you do that you need to create a tfvars file in the `terraform`
folder:

```bash
cat > terraform/terraform.tfvars <<EOF
billing_account = "A1B2C3-A1B2C3-A1B2C3"
project_id      = "your-project-id"
key_project_id  = "your-kms-project-id"
key_admin_email = "john.doe@gmail.com"
EOF
```

As a best practice, you should have a separate GCP project for storing your KMS
keys. Therefore, you need two projects. You can either create them manually or
set `project_create = true` in `projects.tf`.

This step will create an Artifact Registry Docker repository and an asymmetric
key in Cloud KMS.

### 2. Run CI

```bash
cd src
./ci.sh
```

This will build your container image, tag it, produce a SBOM with **syft**
and... fail because **grype** finds a critical vulnerability.

### 3. Fix the Vulnerability

In `go.mod`, change go version from `1.21.1` to `1.21.3`. Next, update tag from
v1.0.0 to v1.0.1, then re-run `ci.sh`.

You will build another image, produce a SBOM, perform vulnerability scanning
(which should pass, unless new vulnerabilities are discovered, you never know),
push the container image to Artifact Registry, sign the image with **cosign**,
which reads signing key from Cloud KMS.

Now you have a signed and verifiable container image in Artifact Registry.

### 4. Run CD

```bash
cd src
./cd.sh
```

In this way, first, you verify the container signature, then you pretend to
deploy to GCP. If you really want to deploy on Google Cloud, you can uncomment
the contents of `run.tf` and run `terraform apply`.
