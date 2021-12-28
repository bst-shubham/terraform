terraform {
  backend "s3" {
    bucket = "dev-now-gg-terraform-up-and-running-state-shubham"
    key = "main"
    region = "ap-south-1"
    dynamodb_table = "S3-Terraform-Statefile-Table"
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}
