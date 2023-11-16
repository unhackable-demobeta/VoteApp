variable "AWS_REGION" {
  description = "AWS region.  Example: us-east-2"
}

terraform {
  required_providers {
    ssh = {
      source  = "loafoe/ssh"
      version = "1.0.1"
    }
  }
}

provider "aws" {
  region = data.terraform_remote_state.eks.outputs.region
}