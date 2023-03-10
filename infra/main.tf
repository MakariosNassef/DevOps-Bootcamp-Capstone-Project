module "network_module" {
  source                    = "./network"
  MAIN_VPC                  = "main-vpc"
  IGW_NAME                  = "igw_main"
  NAT_NAME                  = "nat_gw"
  PUBLIC_ROUTE_NAME         = "public_route_table"
  PRIVATE_ROUTE_NAME        = "private_route_table"
  PUBLIC_ROUTE_CIDER        = "0.0.0.0/0"
  PRIVATE_ROUTE_CIDER       = "0.0.0.0/0"
  AVAILABILITY_ZONE_A       = "us-east-1a"
  AVAILABILITY_ZONE_B       = "us-east-1b"
  PRIVATE_SUBNET_CIDR_BLOCK = "10.0.2.0/24"
  PUBLIC_SUBNET_CIDR_BLOCK  = "10.0.0.0/24"
  PRIVATE_SUBNET_NAME       = "private-us-east-1a"
  PUBLIC_SUBNET_NAME        = "public-us-east-1a"
}


module "cluster_module" {
  source            = "./cluster"
  VPC_ID            = module.network_module.VPC_ID_OUTPUT
  PRIVATE_SUBNET_ID = module.network_module.PRIVATE_SUBNET_ID_OUTPUT
  PUBLIC_SUBNET_ID  = module.network_module.PUBLIC_SUBNET_ID_OUTPUT
  CLUSTER_NAME      = "eks"
}
