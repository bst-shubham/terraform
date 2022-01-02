terraform {
  backend "s3" {
    bucket = "dev-now-gg-terraform-up-and-running-state-shubham"
    key = "main"
    region = "ap-south-1"
    dynamodb_table = "S3-Terraform-Statefile-Table"
  }
}
resource "aws_vpc" "NowggVpc" {
    cidr_block = var.VpcCidrBlock
    instance_tenancy = var.InstanceTenancy
    enable_dns_support = var.EnableDnsSupport
    enable_dns_hostnames = var.DnsHostName
}

resource "aws_internet_gateway" "Internet_Gateway" {
    vpc_id = aws_vpc.NowggVpc.id
    tags = {
        Name = "Nowgg Internet Gateway"
    }

}

resource "aws_route" "Nowggdefaultroute" {
    route_table_id = aws_vpc.NowggVpc.default_route_table_id
    destination_cidr_block = var.destinationcidrblock
    gateway_id = aws_internet_gateway.Internet_Gateway.id
}

resource "aws_subnet" "public" {
    count = "${length(var.availability_zones)}"
    vpc_id = aws_vpc.NowggVpc.id
    cidr_block = "${cidrsubnet(var.cidr_block_subnet, 8, count.index)}"
    map_public_ip_on_launch = true
    tags = {
        "Name" = "prod-extended-subnet- ${element(var.availability_zones, count.index)}"
    }
}

resource "aws_route_table_association" "subnet_route_association" {
    route_table_id = aws_vpc.NowggVpc.default_route_table_id
    count = "${length(var.availability_zones)}"
    subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
}





