terraform {
  backend "s3" {
    bucket = "terraform-state-aditya-001"
    key    = "production/terraform.tfstate"
    region = "ap-south-1"
  }
}
