
resource "aws_vpc" "terraform-vpc" {
  cidr_block = "172.23.0.0/16"
  tags = {
    Name = "terraform-vpc"
  }
}
