provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  tags = {
    Name = "terraform example"
  }
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello! Message from simple webserv" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"
  ingress {
    from_port = var.server_port
    protocol  = "tcp"
    to_port   = var.server_port
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "server_port" {
  description = "Port used for http requests"
  type = number
  default = 8080
}

output "public_ip" {
  description = "Public IP address of server WWW"
  value = aws_instance.example.public_ip
}

