# Create VPC Terraform Module
module "my-internet-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"


# VPC basics details
  name = "vpc-dev-internet"
  cidr = "10.2.0.0/16"
  azs = var.availability_zone_names
  private_subnets = ["10.2.1.0/24", "10.2.2.0/24"]
  public_subnets = ["10.2.101.0/24", "10.2.102.0/24"]
  

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



