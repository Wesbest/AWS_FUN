
module "vpc" {
  source = "../modules/vpc"
  cidr_block = "10.0.0.0/16"
  environment = "main"
  imageid = "amzn2-ami-kernel-5.10-hvm-2.0.202*-x86_64-gp2"
}

