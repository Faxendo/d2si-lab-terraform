###########
#   VPC   #
###########
resource "aws_vpc" "vpc_terraform" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags = {
    Name    = "VPC Terraform"
    Project = "TP Terraform"
  }
}

########################
#   Internet Gateway   #
########################
resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = "${aws_vpc.vpc_terraform.id}"
}

####################
#   Public Subnet  #
####################
resource "aws_subnet" "public_1" {
  vpc_id = "${aws_vpc.vpc_terraform.id}"

  cidr_block        = "${var.public_subnet}"
  availability_zone = "${var.aws_region_az_1}"

  tags = {
    Name    = "Public Subnet 1"
    Project = "TP Terraform"
  }
}

resource "aws_route_table" "az_1_public" {
  vpc_id = "${aws_vpc.vpc_terraform.id}"

  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.vpc_igw.id}"
  }

  tags = {
    Name    = "Public Subnet Route Table"
    Project = "TP Terraform"
  }
}

resource "aws_route_table_association" "az_1_public" {
  route_table_id = "${aws_route_table.az_1_public.id}"
  subnet_id      = "${aws_subnet.public_1.id}"
}

#####################
#   Private Subnet  #
#####################

resource "aws_subnet" "private_1" {
  vpc_id = "${aws_vpc.vpc_terraform.id}"

  cidr_block        = "${var.private_subnet}"
  availability_zone = "${var.aws_region_az_1}"

  tags = {
    Name    = "Private Subnet 1"
    Project = "TP Terraform"
  }
}

resource "aws_route_table" "az_1_private" {
  vpc_id = "${aws_vpc.vpc_terraform.id}"

  route = {
      cidr_block = "${aws_subnet.public_1.cidr_block}"
  }

  tags = {
    Name    = "Private Subnet Route Table"
    Project = "TP Terraform"
  }
}

resource "aws_route_table_association" "az_1_private" {
  route_table_id = "${aws_route_table.az_1_private.id}"
  subnet_id      = "${aws_subnet.private_1.id}"
}