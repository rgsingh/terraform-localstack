#!/bin/bash -x

# Get environmental variables from shell
source "$SCRIPT_DIR"/variables.sh

###############################################################################
# Create rendered env-file
function setup () {
  # Run time variables

  cd "$SCRIPT_DIR"
  # Reset every run
  echo '# Automatically generated variables' > .env

  for var in ${!TF_VAR*} ; do
    echo "${var}=${!var}" >>.env
  done
}

###############################################################################
# Helper to run terraform in docker (to minimize script requirements)
function terraform () {
  declare ACTION="$1"

  if [[ ${ACTION:?} == init ]] ; then
    # terraform init
    docker build \
    --build-arg AWS_PROFILE="${AWS_PROFILE:?}" \
    --build-arg version="${TERRAFORM_VERSION:?}" \
    --tag terraform:$PROJECT .
  else
    # terraform <action> -with-args
    # This mount allows docker in docker calls
    docker run \
      --tty \
      --rm \
      --env-file .env \
      --env AWS_PROFILE \
      --volume /var/run/docker.sock:/var/run/docker.sock \
      --volume ${AWS_CREDS:?}:/aws:ro \
      terraform:${PROJECT:?} \
      "$@"

  fi
}