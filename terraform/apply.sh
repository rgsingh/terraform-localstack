#!/bin/bash -x

export SCRIPT_DIR="${0%/*}"
###############################################################################
# Cleanup
source "$SCRIPT_DIR"/functions.sh

###############################################################################
# Main execution
setup &&
  terraform init -input-false &&
    terraform plan -out output.tfplan &&
       terraform apply -auto-approve &&
         terraform output -json > output.json

###############################################################################
# Cleanup
unset -f ${!TF_VAR*}