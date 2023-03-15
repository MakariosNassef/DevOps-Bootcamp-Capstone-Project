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

# installing Apache
# variable "user_data"{
#     default = <<-EOF
#         #!/bin/bash
#         echo " Installing apache2"
#         sudo apt update -y
#         sudo apt install apache2 -y
#         echo " Completed Installing apache2"
#         EOF
#     description = "apache2-instance"
# }

