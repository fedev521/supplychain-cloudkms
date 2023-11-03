#!/bin/bash

signing_key=$(terraform -chdir=../terraform output -raw cosign_key)

cosign verify --insecure-ignore-tlog=true --key gcpkms://$signing_key $tagged_image

echo gcloud run deploy svc-run-hello-01 --image=$tagged_image
