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
  profile = "loretta"
}

# Create your vpc
module "vpc" {
  source                              =  "../modules/vpc"
  region                              = var.region
  vpc_project_name                    = var.vpc_project_name
  project_name                        = var.project_name
  vpc_cidr                            = var.vpc_cidr
  public_subnet_az1_cidr              = var.public_subnet_az1_cidr
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
module "nat-gateway" {
  source                             = "../modules/nat-gateway"
  public_subnet_az1_id               = module.vpc.public_subnet_az1_id
  internet_gateway                   = module.vpc.internet_gateway
  public_subnet_az2_id               = module.vpc.public_subnet_az2_id 
  public_subnet_az3_id               = module.vpc.public_subnet_az3_id
  vpc_id                             = module.vpc.vpc_id
  private_app_subnet_az1_id          = module.vpc.private_app_subnet_az1_id
  private_db_subnet_az1_id           = module.vpc.private_db_subnet_az1_id
  private_app_subnet_az2_id          = module.vpc.private_app_subnet_az2_id
  private_db_subnet_az2_id           = module.vpc.private_db_subnet_az2_id
  private_app_subnet_az3_id          = module.vpc.private_app_subnet_az3_id
  private_db_subnet_az3_id           = module.vpc.private_db_subnet_az3_id
}

module "security_groups" {
  source                              = "../modules/security-groups"
  vpc_id                              = module.vpc.vpc_id
  
}

module "ecs_tasks_execution_role" {
  source                             = "../modules/ecs-task-execution-role"
  project_name                       = module.vpc.project_name
  
}

module "acm" {
  source                             = "../modules/acm"
  domain_name                        = var.domain_name
  subject_alternative_names          = var.subject_alternative_names

  
}

module "application_load_balancer" {
  source                             = "../modules/alb"
  project_name                       = module.vpc.project_name
  alb_security_group_id              = module.security_groups.alb_security_group_id
  public_subnet_az1_id               = module.vpc.public_subnet_az1_id
  public_subnet_az2_id               = module.vpc.public_subnet_az2_id
  public_subnet_az3_id               = module.vpc.public_subnet_az3_id
  vpc_id                             = module.vpc.vpc_id
  certificate_arn                    = module.acm.certificate_arn
}