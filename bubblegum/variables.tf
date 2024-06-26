variable "region" {}
variable "vpc_project_name" {}
variable "environment" {}
variable "project_name" {
  
}

#vpc  variable
variable "vpc_cidr" {}
variable "public_subnet_az1_cidr" {}
variable "public_subnet_az2_cidr" {}
variable "public_subnet_az3_cidr" {}
variable "private_app_subnet_az1_cidr" {}
variable "private_app_subnet_az2_cidr" {}
variable "private_app_subnet_az3_cidr" {}
variable "private_db_subnet_az1_cidr" {}
variable "private_db_subnet_az2_cidr" {}
variable "private_db_subnet_az3_cidr" {}

#acm variable
variable "domain_name" {}
variable "subject_alternative_names" {}