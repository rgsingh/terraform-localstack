#!/bin/bash
set -x

export PROJECT=my-cool-app

# Terraform configuration
export TERRAFORM_VERSION="0.13.4"

# Change according to auth method
export AWS_CREDS=~/.aws/credentials

# Non Sensitive vars
export TF_VAR_project="${PROJECT:?}"
#export TF_VAR_git_commit=$(git rev-parse --short HEAD)
export DOCKER_BUILDKIT=0
export COMPOSE_DOCKER_CLI_BUILD=0