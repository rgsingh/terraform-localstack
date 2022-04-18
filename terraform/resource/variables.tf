variable "schedule_expression" {
  description = "Schedule of run"
  type        = string
  default     = "rate(60 minutes)"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "lambda_variables" {
  description = "Lambda variables"
  type = map
  default ={}
}