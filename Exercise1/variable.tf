#Count variable
variable "item_count" {
  description = "default count used to set AZs and instances"
  type        = number
  default     = 2
}

variable "namespace" {
  description = "The project namespace for resource naming"
  default     = "login"
}

variable "region" {
  description = "AWS region"
  default     = "eu-west-1"
}

variable "cidr_block_vpc" {
  description = "cidr block for vpc"
  default     = "10.0.0.0/16"
}

variable "cidr_block_default" {
    type          = string
    default       = "0.0.0.0/0"
    description   = "default CIDR Block"
}

variable "availability_zones" {
  type    = list(string)
  default = ["eu-west-1a", "eu-west-1b"]
}

variable "cidr_block_web" {
    type          = list(string)
    default       = ["10.0.1.0/24", "10.0.2.0/24"]
    description   = "Public Subnet CIDR Block for web layer"
}

variable "cidr_block_app" {
    type          = list(string)
    default       = ["10.0.3.0/24", "10.0.4.0/24"]
    description   = "Private Subnet CIDR Block for app layer"
}

variable "cidr_block_DB" {
    type          = list(string)
    default       = ["10.0.5.0/24", "10.0.6.0/24"]
    description   = "Private Subnet CIDR Block for database layer"
}

#Instance variables
variable "ami_id" {
  description = "default ami"
  type        = string
  default     = "ami-0ad8ecac8af5fc52b"
}

variable "instance_type" {
  description = "default instance type"
  type        = string
  default     = "t2.micro"
}

variable "rds_instance" {
  type = map(any)
  default = {
    allocated_storage   = 10
    engine              = "mysql"
    engine_version      = "8.0.20"
    instance_class      = "db.t2.micro"
    multi_az            = false
    name                = "logindb"
    skip_final_snapshot = true
  }
}

#Create database sensitive variables
variable "user_information" {
  type = map(any)
  default = {
    username = "username"
    password = "password"
  }
  sensitive = true
}

