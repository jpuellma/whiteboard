variable "ami_id" {}
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "app" {
    ami =   "${var.ami_id}"
    instance_type = "t2.micro"
    tags {
        Name = "hello_app"
    }
    key_name = "aws_jpuellma"
    security_groups = ["app"]

    provisioner "remote-exec" {
        inline = [
            "sudo yum -y install ruby && sudo gem install rails -v 3.0.0",
        ]
    }
    connection {
        type = "ssh"
        user = "centos"
        private_key = "${file("/home/jpuellmann/.ssh/aws_jpuellma.pem")}"
    }
}

resource "aws_instance" "db" {
    ami =   "${var.ami_id}"
    instance_type = "t2.micro"
    tags {
        Name = "hello_db"
    }
    key_name = "aws_jpuellma"
    security_groups = ["db"]

    provisioner "remote-exec" {
        inline = [
            "sudo yum -y install mariadb",
        ]
    }
    connection {
        type = "ssh"
        user = "centos"
        private_key = "${file("/home/jpuellmann/.ssh/aws_jpuellma.pem")}"
    }
}

resource "aws_security_group" "app" {
    name = "app"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "db" {
    name = "db"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
