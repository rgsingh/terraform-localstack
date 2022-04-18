#terraform {
#  backend "s3" {
#    bucket                      = "org-tf-state-backend"
#    key                         = "my-cool-app/terraform-tfstate"
#    encrypt                     = true
#    region                      = "us-east-1"
#    dynamodb_table              = "terraform_state"
#  }
#}
data "terraform_remote_state" "localstack" {
  backend = "s3"
  config = {
    bucket                      = "org-tf-state-backend"
    key                         = "my-cool-app/terraform-tfstate"
    encrypt                     = true
    region                      = "us-east-1"
    dynamodb_table              = "terraform_state"
    shared_credentials_file     = "/aws"
  }
}