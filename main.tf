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

resource "aws_subnet" "public" {
    count = "${length(var.availability_zones)}"
    vpc_id = "vpc-0168fff8e4049b41d"
    cidr_block = "${cidrsubnet(var.cidr_block, 8, count.index)}"
    map_public_ip_on_launch = true
    tags = {
        "Name = prod-extended-subnet- ${element(var.availability_zones, count.index)}
    }

}
