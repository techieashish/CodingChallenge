
resource "aws_vpc" "pomelo" {
  cidr_block = "10.0.0.0/26"

  tags = map(
    "Name", "terraform-eks-pomelo-node",
    "kubernetes.io/cluster/${var.polls-app}", "shared",
  )
}

resource "aws_subnet" "pomelo" {
  count = 2

  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "10.0.${count.index}.0/27"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.pomelo.id

  tags = map(
    "Name", "terraform-eks-pomelo-node",
    "kubernetes.io/cluster/${var.cluster-name}", "shared",
  )
}

resource "aws_internet_gateway" "pomelo" {
  vpc_id = aws_vpc.pomelo.id

  tags = {
    Name = "terraform-eks-pomelo"
  }
}

resource "aws_route_table" "pomelo" {
  vpc_id = aws_vpc.pomelo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.pomelo.id
  }
}

resource "aws_route_table_association" "pomelo" {
  count = 2

  subnet_id      = aws_subnet.pomelo.*.id[count.index]
  route_table_id = aws_route_table.pomelo.id
}