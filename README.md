# Terraform (Docker) and LocalStack (Docker) Example

### LocalStack

    docker-compose -f docker-compose-localstack.yml up -d

### Script to manage infrastructure against LocalStack
For Intel chipsets, override the environment variable `DOCKER_DEFAULT_PLATFORM` within `docker-compose-infra.yml`.
The default value is set to `--platform linux/amd64` which references the AMD64 Terraform image for M1 chipsets.

Terrform init

    docker-compose -f docker-compose-infra.yml run --rm terraform init

Terraform plan (single quotes are required)

    docker-compose -f docker-compose-infra.yml run --rm terraform plan -var-file tfvars/input.tfvars -out output.tfplan

Terraform apply (single quotes are required)

    docker-compose -f docker-compose-infra.yml run --rm terraform apply output.tfplan


## Verify Deployment of Infrastructure Resources

    aws lambda list-functions --endpoint-url=http://localhost:4566

## References

    https://github.com/dyordsabuzo/pablosspot/tree/main/ep-11-localstack-setup