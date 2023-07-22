variable "region" {
  description = "AWS region"
  default     = "ap-southeast-1"
}

variable "instance_type" {
  description = "Type of EC2 instance to provision"
  default     = "t2.micro"
}

variable "instance_name" {
  description = "EC2 instance name"
  default     = "Provisioned by Terraform"
}


variable "availability_zone_names" {
  type = list(string)
  default = ["ap-southeast-1a","ap-southeast-1b"]
}
