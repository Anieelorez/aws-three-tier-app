terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
  profile = "terraform-user"
}

# Create your vpc
module "vpc" {
  source                              = "./.. /modules/vpc"
  region                              = var.region
  project_name                        = var.project_name
  vpc_cidr                            = var.vpc_cidr
  public_subnet_az1_cidr              = var.ublic_subnet_az1_cidr
  public_subnet_az2_cidr              = var.public_subnet_az2_cidr
  public_subnet_az3_cidr              = var.public_subnet_az3_cidr
  private_app_subnet_az1_cidr         = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr         = var.private_app_subnet_az2_cidr
  private_app_subnet_az3_cidr         = var.private_app_subnet_az3_cidr
  private_db_subnet_az1_cidr          = var.private_db_subnet_az1_cidr
  private_db_subnet_az2_cidr          = var.private_db_subnet_az2_cidr
  private_db_subnet_az3_cidr          = var.private_db_subnet_az3_cidr
}

#Create natgateway
module "natgateway" {
  source                             = " ./../modules/nat-gateway"
  public_subnet_az1_id               = module.vpc.public_subnet_az1_id
  internet_gateway                   = module.vpc.internet_gateway
  public_subnet_az3_id               = module.vpc.public_subnet_az2_id
  vpc_id                             = module.vpc_id
  private_app_subnet_az1_id          = module.vpc.private_app_subnet_az1_id
  private_db_subnet_az1_id           = module.vpc.private_db_subnet_az1_id
  private_app_subnet_az2_id          = module.vpc.private_app_subnet_az2_id
  private_db_subnet_az2_id           = module.vpc.private_db_subnet_az1.id
  private_app_subnet_az3_id          = module.vpc.private_app_subnet_az3_id
  private_db_subnet_az3_id           = module.vpc.private_db_subnet_az1_id
}