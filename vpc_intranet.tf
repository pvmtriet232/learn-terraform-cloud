

module "my-intranet-vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"

# VPC basics details
  name = "vpc-dev-intranet"
  cidr = "10.1.0.0/16"
  azs = var.availability_zone_names
  private_subnets = ["10.1.3.0/24","10.1.4.0/24"]


# Database Subnets
  create_database_subnet_group = true
  create_database_subnet_route_table = true
  database_subnets = ["10.1.151.0/24", "10.1.152.0/24"] 

# NAT gateway 
# one_nat_gateway_per_az = true
  
  public_subnet_tags = {
    Name = "private-subnets"
  }

}
