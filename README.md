# Terraform (Docker) and LocalStack (Docker) Example

### LocalStack

    docker-compose up -d

### Script to manage infrastructure against LocalStack
For M1 chip, [tf-ls.sh] script uses `--platform linux/amd64` to reference appropriate Terraform image.
Remove this option if not running on a host with an Apple (M1) chip

Terrform init

    ./tf-ls.sh /my-workspace/terraform-localstack init

Terraform plan (single quotes are required)

    ./tf-ls.sh /my-workspace/terraform-localstack 'plan -var-file tfvars/input.tfvars -out output.tfplan'

Terraform apply (single quotes are required)

    ./tf-ls.sh /my-workspace/terraform-localstack 'apply output.tfplan'


## Verify Deployment of Infrastructure Resources

    aws lambda list-functions --endpoint-url=http://localhost:4566

## References

    https://github.com/dyordsabuzo/pablosspot/tree/main/ep-11-localstack-setup