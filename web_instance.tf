##########################
#   Web Security Group   #
##########################

resource "aws_security_group" "web" {
  name        = "vpc_web"
  description = "Allow HTTP-in and SSH from D2SI"

  vpc_id = "${aws_vpc.vpc_terraform.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["176.67.91.153/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project = "TP Terraform"
  }
}

####################
#   Web Instance   #
####################

resource "aws_instance" "web" {
  ami               = "${lookup(var.amis_web, var.aws_region)}"
  availability_zone = "${var.aws_region_az_1}"
  instance_type     = "${var.web_instance}"
  key_name          = "${var.aws_key_name}"

  vpc_security_group_ids = ["${aws_security_group.web.id}"]

  subnet_id = "${aws_subnet.public_1.id}"

  associate_public_ip_address = true
  source_dest_check           = false

  user_data = "${file("${path.module}/templates/web.tmpl")}"

  tags = {
    Name    = "Web Server"
    Project = "TP Terraform"
  }
}

##############################
#   Web Instance User Data   #
##############################

###########################
#   Web Instance Output   #
###########################

output "web_ip" {
  description = "Web Instance public IP"
  value       = "${aws_instance.web.public_ip}"
}
