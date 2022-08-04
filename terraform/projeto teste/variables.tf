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

variable "public_subnets" {
  type        = string
  description = "cidr publico"
  default     = "10.22.1.0/24"
}

variable "private_subnets" {
  type        = string
  description = "cidr privado"
  default     = "10.22.1.0/24"
}