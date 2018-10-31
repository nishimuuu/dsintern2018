resource "aws_security_group" "public" {
  name        = "allow_all traffic"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.sandbox.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private" {
  name        = "allow only public subnet"
  description = "Allow only public subnet"
  vpc_id      = "${aws_vpc.sandbox.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_groups = ["${aws_security_group.public.id}"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
