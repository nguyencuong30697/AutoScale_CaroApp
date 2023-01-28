data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.12.0"

  name    = "${var.project}_VPC"
  cidr    = var.vpc_cidr
  azs     = data.aws_availability_zones.available.names
  public_subnets   = var.public_subnets

  enable_nat_gateway           = false
}

module "lb_sg" {
  source = "terraform-in-action/sg/aws"
  vpc_id = module.vpc.vpc_id
  ingress_rules = [
    {
      port        = 80
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "web_sg" {
  source = "terraform-in-action/sg/aws"
  vpc_id = module.vpc.vpc_id
  ingress_rules = [
    {
      port        = 80
      security_groups = [module.lb_sg.security_group.id]
    }
  ]
}
