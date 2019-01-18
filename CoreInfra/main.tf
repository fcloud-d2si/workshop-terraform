resource "aws_vpc" "tf-vpc" {
  cidr_block = "172.23.0.0/16"
  tags = {
    Name = "tf-vpc"
  }
}

resource "aws_internet_gateway" "tf-igw" {
  vpc_id     = "${aws_vpc.tf-vpc.id}"
  tags = {
    Name = "tf-igw"
  }
}

resource "aws_route_table" "tf-rt-priv" {
  vpc_id     = "${aws_vpc.tf-vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.tf-igw.id}"
  }
  tags = {
    Name = "tf-rt-priv"
  }
}

resource "aws_subnet" "tf-subnet-priv" {
  count = 2
  vpc_id     = "${aws_vpc.tf-vpc.id}"
  cidr_block = "172.23.${count.index+1}.0/24"
  tags = {
    Name = "tf-subnet-priv-${count.index+1}"
  }
}

resource "aws_route_table_association" "a" {
  count = 2
  subnet_id      = "${element(aws_subnet.tf-subnet-priv.*.id, count.index)}"
  route_table_id = "${aws_route_table.tf-rt-priv.id}"
}
