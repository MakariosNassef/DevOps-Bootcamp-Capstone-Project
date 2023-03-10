variable "MAIN_VPC" {
  description = "aws_vpc_Name"
  type        = string
}
variable "IGW_NAME" {
  description = "igw_name"
  type        = string
}
variable "NAT_NAME" {
  description = "nat_name"
  type        = string

}
variable "PUBLIC_ROUTE_NAME" {
  description = "Name of public_route_table"
  type        = string

}
variable "PUBLIC_ROUTE_CIDER" {
  description = "route table cider block to public"
  type        = string

}
variable "PRIVATE_ROUTE_NAME" {
  description = "Name of private_route_table"
  type        = string

}
variable "PRIVATE_ROUTE_CIDER" {
  description = "route table cider block to public"
  type        = string

}
variable "AVAILABILITY_ZONE_A" {
  description = "availability_zone for subnets"
  type        = string

}
variable "AVAILABILITY_ZONE_B" {
  description = "availability_zone for subnets"
  type        = string

}
variable "PRIVATE_SUBNET_CIDR_BLOCK" {
  description = "PRIVATE_SUBNET_CIDR_BLOCK"
  type        = string
}
variable "PUBLIC_SUBNET_CIDR_BLOCK" {
  description = "PUBLIC_SUBNET_CIDR_BLOCK"
  type        = string
}
variable "PRIVATE_SUBNET_NAME" {
  description = "PRIVATE_SUBNET_NAME"
  type        = string
}
variable "PUBLIC_SUBNET_NAME" {
  description = "PUBLIC_SUBNET_NAME"
  type        = string
}


