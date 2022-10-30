provider "aws" {
  region = var.region
}
# Creation of Ec2 instance (Reusing the module )
module "e2instanceModule" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami                    = var.ami
  instance_type          = "t2.micro"
  #key_name               = "user1"
  monitoring             = true
  #vpc_security_group_ids = ["sg-12345678"]
  #subnet_id              = data.aws_subnets.private

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}



module "vote_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "user-service"
  description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
  #vpc_id      = "vpc-12345678"

  ingress_cidr_blocks      = ["10.10.0.0/16"]
  ingress_rules            = ["https-443-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8090
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "10.10.0.0/16"
    },
    {
      rule        = "postgresql-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}
