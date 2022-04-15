# Terraform (Docker) and LocalStack (Docker) Example

### Limitations

This example illustrates the basic concept of hosting a local Terraform environment which manages infrastructure
against a Localstack container. This is somewhat incomplete approach with inherent problems that could be
further addressed with a custom Terraform image, supporting scripts, and a data store to host remote state.
Terraform Cloud offers a more robust solution for managing versioned state. However, a local Terraform
setup may be needed when working with other containers or when performing a Proof-of-Concept for an application.

The following known limitations can be distilled as followed:

* Host to Docker volume mapping and host AWS credentials passing
* No base Terraform image to manage Terraform runtime and downloaded provider plug-ins
  * Typically, this image would be built and added to a registry.
* No "control" Terraform container:
  * Created via a multi-stage Dockerfile which defines how to accept external environment variables
  * Invoke terraform init
* No control scripts to wrap all of the Terraform commands: plan, apply, destroy
  * Each Terraform command should 
    
Effectively, the Terraform container should be responsible for setting up environment variables needed prior to terraform init

For example:

          export TF_CLI_ARGS_init="-backend-config='bucket=sample-platform-setting'"
          export TF_CLI_ARGS_init="$TF_CLI_ARGS_init -backend-config='key=state'"
          export TF_CLI_ARGS_init="$TF_CLI_ARGS_init -backend-config='region=${AWS_DEFAULT_REGION}'"

          terraform init

Terraform commands plan or apply may also require their own environment variable depending
upon what controls are needed for the Terraform version being used. With the augmented approach mentioned, pinning
a Terraform version is possible which may prevent a user/developer from inadvertantly applying state with a different
version of Terraform.

### LocalStack

    docker-compose -f docker-compose-localstack.yml up -d

### Environment Setup

A localstack AWS_PROFILE must exist prior to performing the Terraform infrastructure setup. Add the following
to ~/.aws/credentials:
    
    [localstack]
    aws_access_key_id=test
    aws_secret_access_key=test
    region=us-east-1
    output=json

Enable the profile via command line:

    export AWS_PROFILE=localstack

### Script to manage infrastructure against LocalStack
For Intel chipsets, override the environment variable `DOCKER_DEFAULT_PLATFORM` within `docker-compose-infra.yml`.
The default value is set to `--platform linux/amd64` which references the AMD64 Terraform image for M1 chipsets.

Terrform init

    docker-compose -f docker-compose-infra.yml run --rm terraform init

Terraform plan 

    docker-compose -f docker-compose-infra.yml run --rm terraform plan -var-file tfvars/input.tfvars -out output.tfplan

Terraform apply 

    docker-compose -f docker-compose-infra.yml run --rm terraform apply output.tfplan


## Verify Deployment of Infrastructure Resources

    aws lambda list-functions --endpoint-url=http://localhost:4566
