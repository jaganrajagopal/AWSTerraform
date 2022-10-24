provider "aws" {
  region  = "${var.region}"
  version = "~> 2.0"
}
# Creation of Ec2 instance (Reusing the module )
module "e2instanceModule" {
    source = "../Modules/ec2"
    
  
}
module "aws_vpc" {
    source = "../Modules/vpc"
  
}
module "securitygroup_ec2_nginx" {
    source = "../Modules/security"
  
}
