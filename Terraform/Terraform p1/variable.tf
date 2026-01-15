variable "aws_region" {
  default = "ap-south-1"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  description = "EC2 Key Pair name"
}

variable "private_key_path" {
  description = "Path to private key (.pem) file"
  type        = string
}