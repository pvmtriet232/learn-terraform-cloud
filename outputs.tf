
output "vpc_id_internet" {
  value = module.my-internet-vpc.vpc_id
}

output "vpc_id_intranet" {
  value = module.my-intranet-vpc.vpc_id
}

