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