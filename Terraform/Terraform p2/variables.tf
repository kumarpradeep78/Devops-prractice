variable "key_name" {
  type        = string
  description = "EC2 key pair name"
}

variable "private_key_path" {
  type        = string
  description = "Path to private key .pem file"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
}

variable "flask_port" {
  default = 8000
}

variable "express_port" {
  default = 8080
}

variable "ami" {
  type    = string
  default = "ami-02b8269d5e85954ef"
}
f