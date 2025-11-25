resource "aws_vpc" "Task6-VPC-Zaeem" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Task6-VPC-Zaeem"
  }
  
}

resource "aws_internet_gateway" "Task6-IGW-Zaeem" {
  vpc_id = aws_vpc.Task6-VPC-Zaeem.id

  tags = {
    Name = "Task6-IGW-Zaeem"
  }
  
}

resource "aws_nat_gateway" "Task6-NAT-Gateway-Zaeem" {
  allocation_id = aws_eip.Task6-NAT-EIP-Zaeem.id
  subnet_id     = aws_subnet.Task6-Public-SubnetA-Zaeem.id

  tags = {
    Name = "Task6-NAT-Gateway-Zaeem"
  }
  
}

resource "aws_route_table" "Task6-Public-RT-Zaeem" {
  vpc_id = aws_vpc.Task6-VPC-Zaeem.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.Task6-IGW-Zaeem.id
    }

  tags = {
    Name = "Task6-Public-RT-Zaeem"
  }
  
}

resource "aws_route_table" "Task6-Private-RT-Zaeem" {
  vpc_id = aws_vpc.Task6-VPC-Zaeem.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.Task6-NAT-Gateway-Zaeem.id
    }

  tags = {
    Name = "Task6-Private-RT-Zaeem"
  }
  
}

resource "aws_route_table_association" "Task6-PublicA-RT-Association-Zaeem" {
    subnet_id = aws_subnet.Task6-Public-SubnetA-Zaeem.id
    route_table_id = aws_route_table.Task6-Public-RT-Zaeem.id
}

resource "aws_route_table_association" "Task6-PublicB-RT-Association-Zaeem" {
    subnet_id = aws_subnet.Task6-Public-SubnetB-Zaeem.id
    route_table_id = aws_route_table.Task6-Public-RT-Zaeem.id
}

resource "aws_route_table_association" "Task6-PrivateA-RT-Association-Zaeem" {
    subnet_id = aws_subnet.Task6-Private-SubnetA-Zaeem.id
    route_table_id = aws_route_table.Task6-Private-RT-Zaeem.id
}

resource "aws_route_table_association" "Task6-PrivateB-RT-Association-Zaeem" {
    subnet_id = aws_subnet.Task6-Private-SubnetB-Zaeem.id
    route_table_id = aws_route_table.Task6-Private-RT-Zaeem.id
}

resource "aws_subnet" "Task6-Public-SubnetA-Zaeem" {
  vpc_id                  = aws_vpc.Task6-VPC-Zaeem.id
  cidr_block              = var.public_sna_cidr
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

  tags = {
    Name = "Task6-Public-SubnetA-Zaeem"
  }
  
}

resource "aws_subnet" "Task6-Public-SubnetB-Zaeem" {
  vpc_id                  = aws_vpc.Task6-VPC-Zaeem.id
  cidr_block              = var.public_snb_cidr
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"
    tags = {
        Name = "Task6-Public-SubnetB-Zaeem"
    }
}

resource "aws_subnet" "Task6-Private-SubnetA-Zaeem" {
  vpc_id                  = aws_vpc.Task6-VPC-Zaeem.id
  cidr_block              = var.private_sna_cidr
  availability_zone = "us-east-1a"
    tags = {
        Name = "Task6-Private-SubnetA-Zaeem"
    }
}

resource "aws_subnet" "Task6-Private-SubnetB-Zaeem" {
  vpc_id                  = aws_vpc.Task6-VPC-Zaeem.id
  cidr_block              = var.private_snb_cidr
  availability_zone = "us-east-1b"
    tags = {
        Name = "Task6-Private-SubnetB-Zaeem"
    }
}

resource "aws_eip" "Task6-NAT-EIP-Zaeem" {
  depends_on = [ aws_internet_gateway.Task6-IGW-Zaeem ]

  tags = {
    Name = "Task6-NAT-EIP-Zaeem"
  }

}