resource "aws_security_group" "security_group" {
  name_prefix = "${var.project_name}-sg"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }

  tags = {
    Name = "${var.project_name}-sg"
  }
  depends_on = [aws_vpc.vpc, aws_subnet.private, aws_subnet.public]
}
