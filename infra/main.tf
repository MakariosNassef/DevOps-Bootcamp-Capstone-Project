module "network_module" {
  source                     = "./network"
  MAIN_VPC                   = "main-vpc"
  MAIN_VPC_CIDR_BLOCK        = "10.0.0.0/16"
  IGW_NAME                   = "igw_main"
  NAT_NAME                   = "nat_gw"
  PUBLIC_ROUTE_NAME          = "public_route_table"
  PRIVATE_ROUTE_NAME         = "private_route_table"
  PUBLIC_ROUTE_CIDER         = "0.0.0.0/0"
  PRIVATE_ROUTE_CIDER        = "0.0.0.0/0"
  AVAILABILITY_ZONE_A        = "us-east-1a"
  AVAILABILITY_ZONE_B        = "us-east-1b"
  PRIVATE_SUBNET_CIDR_BLOCK  = "10.0.2.0/24"
  PUBLIC_SUBNET_CIDR_BLOCK   = "10.0.0.0/24"
  PRIVATE_SUBNET_NAME        = "private-us-east-1a"
  PUBLIC_SUBNET_NAME         = "public-us-east-1b"
  PUBLIC_SUBNET_NAME_2       = "private-us-east-2a"
  PUBLIC_SUBNET_CIDR_BLOCK_2 = "10.0.1.0/24"
}

module "cluster_module" {
  source               = "./cluster"
  VPC_ID               = module.network_module.VPC_ID_OUTPUT
  PRIVATE_SUBNET_ID    = module.network_module.PRIVATE_SUBNET_ID_OUTPUT
  PUBLIC_SUBNET_ID     = module.network_module.PUBLIC_SUBNET_ID_OUTPUT
  PUBLIC_SUBNET_ID_2   = module.network_module.PUBLIC_SUBNET_ID_OUTPUT_2
  CLUSTER_NAME         = "eks"
  namespace            = "namespace_ebs"
  service_account_name = "sa_ebs"
}

module "ecr_module" {
  source   = "./ecr"
  ecr_name = "aws_ecr"
}

module "instance_module" {
  source           = "./instance"
  AMI              = "ami-0557a15b87f6559cf"
  INSTANCE_TYPE    = "t2.micro"
  PUBLIC_SUBNET_ID = module.network_module.PUBLIC_SUBNET_ID_OUTPUT
  MAIN_VPC_ID      = module.network_module.VPC_ID_OUTPUT
  EGRESS_CIDR      = "0.0.0.0/0"
  INGRESS_CIDER    = "0.0.0.0/0"
  KEY_PAIR         = "mac-keyPair"
}