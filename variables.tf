variable "VpcCidrBlock" {
    type = string
}

variable "InstanceTenancy" {
    default = "default"
}

variable "EnableDnsSupport" {
    default = true
}

variable "DnsHostName" {
    default = true
}

variable "region" {
    default = "sa-east-1"
}

variable "destinationcidrblock" {
    default = "0.0.0.0/0"
}

variable "cidr_block_subnet" {
    type = string
}

variable "availability_zones" {
    type = list
}
