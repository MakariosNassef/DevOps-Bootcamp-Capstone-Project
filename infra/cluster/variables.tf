variable "PRIVATE_SUBNET_ID" {
  type = string
}

variable "PUBLIC_SUBNET_ID" {
  type = string
}

variable "VPC_ID" {
  type = string
}

variable "CLUSTER_NAME" {
  type = string
}

variable "namespace" {
  description = "The Kubernetes namespace in which your EBS CSI driver deployment exists"
  type        = string
}

variable "service_account_name" {
  description = "The name of your Kubernetes service account"
  type        = string
}