// access key for the aws user by assigning the role assignment 

provider "aws"{

 //region ="us-east-2"
 access key  = var.access_key
 secret key  = var.secret_key
 region = var.region 
 


//  var.access_key = "AKIARUMJ2LF6TDDLVEVM"
 //secret_key = "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"
 
}
 
 
#Create security group with firewall rules
resource "aws_security_group" "my_security_group" {
  name        = var.security_group
  description = "security group for Ec2 instance"


 ingress {
    from_port   = var.web_ports
    to_port     = var.web_ports
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 


 # outbound from jenkis server
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = var.security_group
  }
}




# Create AWS ec2 instance
resource "aws_instance" "myFirstInstance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  security_groups= [var.security_group]
  
 tags= {
    Name = var.tag_name
  }
}

# Create Elastic IP address
resource "aws_eip" "myFirstInstance" {
  vpc      = true
  instance = aws_instance.myFirstInstance.id

 tags= {
    Name = "my_elastic_ip"
  }


#install appache in linux VM
provisioner "remote-exec" {

inline  = [
"sudo mkdir -p /var/www/html",
"sudo yum update -y",
"sudo yum install -y httpd",
"sudo service http start",
"sudo usermod -a -G apache ec2-user",
"sudo chown -R ec2-user:appache /var/www",
"sudo yumm install -y mysql php php-mysql"
  
  ]

}

provisioner "file" {

source = "index.php"
destination = "/var/www/html/index.php"
}

connection {
type = "ssh"
user = "ec2-user"
password = ""
private_key = "${file("/home/ec2-user/private_key.pem")}"
}
}
}

