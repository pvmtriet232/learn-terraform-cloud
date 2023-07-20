# Create VPC Terraform Module
module "my-internet-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"


# VPC basics details
  name = "vpc-dev-internet"
  cidr = "10.0.0.0/16"
  azs = var.availability_zone_names
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
  

  enable_nat_gateway = true
  single_nat_gateway = false  
  one_nat_gateway_per_az = true
  reuse_nat_ips = true
  external_nat_ip_ids = "${aws_eip.nat.*.id}" 

  tags = {
    Terraform = "true"
    Environment = "dev"
  }  
  

}
resource "aws_eip" "nat" {
  count = 3
  vpc = true
}


/*
module "my-intranet-vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"

# VPC basics details
  name = "vpc-dev-intranet"
  cidr = "10.1.0.0/16"
  azs = ["ap-southeast-1a", "ap-southeast-1b"]
  private_subnets = ["10.0.3.0/24","10.0.4.0/24"]


# Database Subnets
  create_database_subnet_group = true
  create_database_subnet_route_table = true
  database_subnets = ["10.0.151.0/24", "10.0.152.0/24"] 
# NAT gateway 
  one_nat_gateway_per_az = true
  
# VPC DNS Parameters
  enable_dns_hostname = true
  enable_dns_support = true

  public_subnet_tags = {
    Name = "private-subnets"
  }

}
*/
variable "availability_zone_names" {
  type = list(string)
  default = ["ap-southeast-1a","ap-southeast-1b"]
}




