provider "aws" {
  region = var.region
}

terraform {

  cloud {
    organization = "pvmtriet"

    workspaces {
      name = "learn-terraform-cloud"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.28"
    }
    random = {
      source = "hashicorp/random"
      version = ">= 3.0" 
    }
    cloudinit = {
      source = "hashicorp/cloudinit"
      version = ">= 2.1"
    }
  }

  required_version = ">= 0.15"
}
