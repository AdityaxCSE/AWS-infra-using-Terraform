module "vpc" {
  source   = "../../modules/vpc"
  vpc_cidr = "10.0.0.0/16"
}

module "ec2" {
  source    = "../../modules/ec2"
  ami       = "ami-03f4878755434977f"
  subnet_id = module.vpc.private_subnet
}
