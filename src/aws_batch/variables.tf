variable "AWS_ACCESS_KEY_ID" {}
variable "AWS_SECRET_ACCESS_KEY" {}

variable "AWS_DEFAULT_REGION" {
  default = "ap-northeast-1"
}

variable "vpc_cidr" {
  default = "10.3.0.0/16"
}

variable "subnet_public1a_cidr" {
  default = "10.3.0.0/24"
}
variable "subnet_public1c_cidr" {
  default = "10.3.2.0/24"
}
variable "subnet_private1a_cidr" {
  default = "10.3.4.0/24"
}
variable "subnet_private1c_cidr" {
  default = "10.3.6.0/24"
}

