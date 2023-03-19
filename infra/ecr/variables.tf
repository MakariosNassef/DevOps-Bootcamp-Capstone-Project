# variable "ecr_name" {
#   description = "The name of the ECR registry"
#   type        = string
#   default     = null
# }


variable "ecr_names" {
  type        = list(string)
  description = "List of all the AD Group names"
}