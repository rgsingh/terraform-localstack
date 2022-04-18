provider "aws" {
  region                      = "us-east-1"
  s3_force_path_style         = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  shared_credentials_file     = "/aws"

  endpoints {
    apigateway       = "http://host.docker.internal:4566"
    cloudformation   = "http://host.docker.internal:4566"
    cloudwatch       = "http://host.docker.internal:4566"
    cloudwatchevents = "http://host.docker.internal:4566"
    cloudwatchlogs   = "http://host.docker.internal:4566"
    dynamodb         = "http://host.docker.internal:4566"
    ec2              = "http://host.docker.internal:4566"
    es               = "http://host.docker.internal:4566"
    firehose         = "http://host.docker.internal:4566"
    iam              = "http://host.docker.internal:4566"
    kinesis          = "http://host.docker.internal:4566"
    lambda           = "http://host.docker.internal:4566"
    route53          = "http://host.docker.internal:4566"
    redshift         = "http://host.docker.internal:4566"
    s3               = "http://host.docker.internal:4566"
    secretsmanager   = "http://host.docker.internal:4566"
    ses              = "http://host.docker.internal:4566"
    sns              = "http://host.docker.internal:4566"
    sqs              = "http://host.docker.internal:4566"
    ssm              = "http://host.docker.internal:4566"
    stepfunctions    = "http://host.docker.internal:4566"
    sts              = "http://host.docker.internal:4566"
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.74.0"
    }
  }
}
