locals {
  project = "AutoScale-StaticWeb"
}

provider "aws" {
  region = "ap-northeast-1"
}

module "networking" {
  source = "./modules/networking"

  project          = local.project
  vpc_cidr         = "10.23.0.0/16"
  public_subnets   = ["10.23.2.0/24", "10.23.4.0/24", "10.23.6.0/24"]
}

module "autoscaling" {
  source = "./modules/autoscaling"

  project   = local.project
  vpc       = module.networking.vpc
  sg        = module.networking.sg
}