# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  # Must be enabled for EFS
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.MAIN_VPC
  }
}

# communication between your VPC and the internet.
resource "aws_internet_gateway" "igw_main" {
  # The VPC ID to create in.
  vpc_id = aws_vpc.main.id

  #A map of tags to assign to the resource.
  tags = {
    Name = var.IGW_NAME
  }
}

resource "aws_subnet" "private_us_east_1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.PRIVATE_SUBNET_CIDR_BLOCK
  availability_zone = var.AVAILABILITY_ZONE_A

  tags = {
    "Name" = var.PRIVATE_SUBNET_NAME
    # set to the value "1", which mean that this Elastic Load Balancer is intended for internal use only within the cluster. 
    "kubernetes.io/role/internal-elb" = "1"
    # set to "owned", which indicate that the cluster named "demo" owns this resource.
    "kubernetes.io/cluster/eks" = "owned"
  }
}

resource "aws_subnet" "public_us_east_1a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.PUBLIC_SUBNET_CIDR_BLOCK
  availability_zone       = var.AVAILABILITY_ZONE_B
  map_public_ip_on_launch = true

  tags = {
    "Name"                      = var.PUBLIC_SUBNET_NAME
    "kubernetes.io/role/elb"    = "1"
    "kubernetes.io/cluster/eks" = "shared"
  }
}

# Each NAT gateway is created in a specific Availability Zone
resource "aws_eip" "nat1" {
  #EIP may require IGW to exist prior to association .
  #Use depends_on to set an explicit dependency on the IGW.
  depends_on = [aws_internet_gateway.igw_main]
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat1.id
  subnet_id     = aws_subnet.public_us_east_1a.id

  tags = {
    Name = var.NAT_NAME
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw_main]
}

// i will create 2 route table 1 for private subnet and 1 is public route table 
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.PUBLIC_ROUTE_CIDER
    gateway_id = aws_internet_gateway.igw_main.id
  }

  tags = {
    Name = var.PUBLIC_ROUTE_NAME
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = var.PRIVATE_ROUTE_CIDER
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = var.PRIVATE_ROUTE_NAME
  }
}

resource "aws_route_table_association" "private_route_1a" {
  subnet_id      = aws_subnet.private_us_east_1a.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "public_route_1a" {
  subnet_id      = aws_subnet.public_us_east_1a.id
  route_table_id = aws_route_table.public_route_table.id
}

