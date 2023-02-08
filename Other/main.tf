
module "vpc" {
  source = "../modules/vpc"
  cidr_block = "10.0.0.0/24"
  environment = "main"
  subnets = {dev = "10.0.0.0/26", test = "10.0.0.64/26", prod = "10.0.0.128/26"}
}

