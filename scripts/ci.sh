#!/bin/bash
set -e

repo=$(terraform -chdir=../terraform output -raw artifact_registry_repository)
tag="v1.0.0"
tagged_image="$repo/run-hello:$tag"

# build image
docker build -t $tagged_image .

# produce sbom
syft docker:$tagged_image --scope all-layers -o syft-json > sbom.json

# scan for vulnerabilities
grype sbom:./sbom.json \
  --add-cpes-if-none \
  --ignore-states not-fixed,wont-fix \
  --fail-on critical \
  -o json > vulnerabilities.json

# push image
docker push $tagged_image

# sign image
signing_key=$(terraform -chdir=../terraform output -raw cosign_key)
image_with_sha=$(docker inspect --format='{{index .RepoDigests 0}}' $tagged_image)
cosign sign --tlog-upload=false --key gcpkms://$signing_key $image_with_sha
