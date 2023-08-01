data "aws_availability_zones" "available" {}

module "vpc-intranet" { #A
  source                           = "terraform-aws-modules/vpc/aws"
  version                          = "2.64.0"
  name                             = "${var.namespace}-vpc"
  cidr                             = "10.0.0.0/16"
  azs                              = data.aws_availability_zones.available.names
  private_subnets                  = ["10.0.1.0/24", "10.0.2.0/24"]
  database_subnets                 = ["10.0.21.0/24", "10.0.22.0/24" ]
  
  create_database_subnet_group     = true
  create_database_subnet_route_table = true
  private_subnet_tags = {
    Name = "private-subnets"
  }
}

module "lb_sg" {
  source = "terraform-in-action/sg/aws"
  vpc_id = module.vpc-intranet.vpc_id
  ingress_rules = [{
    port        = 80
    cidr_blocks = ["0.0.0.0/0"]
  }]
}

module "websvr_sg" {
  source = "terraform-in-action/sg/aws"
  vpc_id = module.vpc-intranet.vpc_id
  ingress_rules = [
    {
      port            = 8080
      security_groups = [module.lb_sg.security_group.id]
    },
    {
      port        = 22 #C
      cidr_blocks = ["10.0.0.0/16"] #C
    }
  ]
}

module "db_sg" {
  source = "terraform-in-action/sg/aws"
  vpc_id = module.vpc-intranet.vpc_id
  ingress_rules = [{
    port            = 3306
    security_groups = [module.websvr_sg.security_group.id]
  }]
}

