variable "INSTANCE_TYPE" {
  type        = string
  description = "instance_type"
}
variable "KEY_PAIR" {
  type = string
}

variable "AMI" {
  description = "AMI"
}

variable "PUBLIC_SUBNET_ID" {
  type = string
}

variable "MAIN_VPC_ID" {
  type = string
}

variable "EGRESS_CIDR" {
  type = string
}

variable "INGRESS_CIDER" {
  type = string
}

# variable "USER_DATA"{
#     default = <<-EOF
#         #!/bin/bash
#         echo " Installing Nginx"
#         sudo apt update -y &&
#         sudo apt install -y nginx
#         echo " Completed Installing Nginx"
#         EOF
#     description = "Nginx Installation user Data"
# }

