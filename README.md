# Secure Software Supply Chain Demo

Build a container image, produce a SBOM, scan for vulnerabilities, sign that
container image with keys stored in Cloud KMS on Google Cloud. Then, deploy the
container to Cloud Run.

## Prerequisites

Tools:

- gcloud
- docker
- terraform
- [https://github.com/sigstore/cosign](cosign)
- [https://github.com/anchore/syft](syft)
- [https://github.com/anchore/grype](grype)
