
# Sample to Deploy Infrastructure and Application Localstack via Containerized Terraform

This example assumes the existence of a `localstack` AWS profile in an `~/.aws/credentials` file:

    [localstack]
    aws_access_key_id=test
    aws_secret_access_key=test
    region=us-east-1
    output=json

Deploy infrastructure locally:

    cd terraform

    export AWS_PROFILE=localstack && ./apply.sh

## Validate Deployment of Terraform State to Remote (Localstack) S3 Store

    aws s3api list-objects --bucket org-tf-state-backend --endpoint-url=http://localhost:4566


## Validate Deployment to Localstack of Application Resources

    aws lambda list-functions --endpoint-url=http://localhost:4566
