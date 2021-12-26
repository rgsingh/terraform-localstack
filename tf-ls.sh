#!/bin/sh
set -e

if (( $# < 2 )); then
    echo "usage: tf-ls.sh absolute-path-to-scripts-directory [init | 'plan -var-file tfvars/input.tfvars -out output.tfplan' | 'apply output.tfplan']"
    exit 1
else
    echo "Working directory set to: $1"
fi

WORKING_DIR=$1
COMMAND=$2

docker run --name tf-ls --rm --platform linux/amd64 -v $PWD:$WORKING_DIR \
    -v $PWD/localstack/providers.tf:$WORKING_DIR/infrastructure/providers.tf \
    -w $WORKING_DIR/infrastructure \
    --network localstack hashicorp/terraform $COMMAND
