// web-ports defined for the linux vm
variable "web-ports"{

default = ["20","80","443","81","8080"]

}

// access key for aws 
variable "access_key" {

    default = "AKIARUMJ2LF6TDDLVEVM"
}

// secret key for aws
variable "secret_key" {

    default = "ZlbfJD6RlO4FQ+fa7BxRQSkU/iUI/T6qL7P1exWH"
}


variable "region"
 {
     
     default = "us-east-2"

 }



// type for EC2 Instance (free tier)
variable "instance_type" {
  description = "instance type for ec2"
  default     =  "t2.micro"
}


variable "security_group" {
  description = "Name of security group"
  default     = "my-jenkins-security-group"
}

variable "tag_name" {
  description = "Tag Name of for Ec2 instance"
  default     = "my-ec2-instance"
}

variable "ami_id" {
  description = "AMI for Ubuntu Ec2 instance"
  default     = "ami-08a57643245353515"
}
