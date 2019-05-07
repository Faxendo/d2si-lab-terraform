terraform {
    backend "s3" {
        bucket = "d2si-tp-terraform-shauni"
        key = "tp-1/terraform.tfstate"
        region = "eu-west-1"       
    }
}