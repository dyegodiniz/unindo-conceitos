# variable "subnet_id_1" {
#   type = string
#   default = "subnet-your_first_subnet_id"
#  }

#  variable "subnet_id_2" {
#   type = string
#   default = "subnet-your_second_subnet_id"
#  }

variable "region" {
  type        = string
  description = "regiao da aws"
  default     = "us-east-2"
}

variable "main_vpc_cidr" {
  type        = string
  description = "vpc cidr"
  default     = "10.22.0.0/16"
}

variable "subnet1" {
  type        = string
  description = "subnet 1"
  default     = "10.22.1.0/24"
}

variable "subnet2" {
  type        = string
  description = "subnet 2"
  default     = "10.22.2.0/24"
}