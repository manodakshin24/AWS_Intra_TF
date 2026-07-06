# GitHub Actions Workflow: Terraform GCP

## Overview

This workflow ([`.github/workflows/deploy.yaml`](.github/workflows/deploy.yaml)) automates Terraform validation and planning for GCP infrastructure.

## Triggers

- **Push**: Any push to `main` branch
- **Pull Request**: Any PR opened against the repository

## Permissions

```yaml
permissions:
  contents: read          # Read repository code
  id-token: write         # Required for Workload Identity Federation
  pull-requests: write    # Comment on PRs (optional, for future use)

Authentication - Uses Workload Identity Federation (WIF) to securely authenticate GitHub Actions to GCP without storing credentials.

Required Secrets:

- GCP_WIF_PROVIDER: Workload identity provider resource path
- GCP_SERVICE_ACCOUNT: Service account email

Setup:

1. GCP → IAM & Admin → Workload Identity Pools → github-pool
2. GitHub Repo → Settings → Secrets and variables → Actions
3. Add both secrets with values from GCP console

Workflow Steps (see chart in image.png)

Environment Variables

TF_IN_AUTOMATION: "true"           # Terraform automation mode
GOOGLE_PROJECT: project-bad2bf27-d410-468a-acf


Workflow Execution Order
1. Code is pushed or PR is opened
2. GitHub Actions runner spins up (ubuntu-latest)
3. Authenticates to GCP via WIF (no credential files stored)
4. Validates Terraform code (fmt, init, validate)
5. Generates and displays plan
6. Workflow completes; runner is destroyed

Local Testing
Before pushing, test locally:

terraform fmt -recursive
terraform init
terraform validate
terraform plan

File: deploy.yaml
Runner: ubuntu-latest (Ubuntu 24.04)
Terraform: 1.7.4
Auth Method: Workload Identity Federation (no stored secrets)