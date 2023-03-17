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

variable "USER_DATA"{
    default = <<-EOF
        #!/bin/bash
        echo " Installing Docker"
        sudo apt update
        sudo apt install apt-transport-https ca-certificates curl software-properties-common
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
        apt-cache policy docker-ce
        sudo apt install docker-ce
        # sudo systemctl status docker
        sudo usermod -aG docker jenkins
        sudo usermod -aG docker ubuntu
        # following command to activate the changes to groups:
        newgrp docker
        sudo apt install awscli
        EOF
    description = "Docker Installation user Data"
}

