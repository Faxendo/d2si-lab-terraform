variable "aws_key_name" {
  description = "Key Pair name to assign to EC2 instance"
}

variable "aws_region" {
  description = "AWS Region"
}

variable "aws_region_az_1" {
  description = "AWS Availability Zone 1"
}

variable "amis_web" {
  description = "Amazon Linux AMIs"

  default = {
    eu-west-1 = "ami-07683a44e80cd32c5"
  }
}

variable "vpc_cidr" {
  description = "VPC CIDR network"
  default     = "172.23.0.0/16"
}

variable "public_subnet" {
  description = "CIDR for public subnet"
  default     = "172.23.1.0/24"
}

variable "private_subnet" {
  description = "CIDR for private subnet"
  default     = "172.23.10.0/24"
}

variable "web_instance" {
  description = "Instance Type to use for web server"
  default     = "t3.nano"
}