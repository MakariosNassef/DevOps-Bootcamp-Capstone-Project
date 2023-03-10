# locals.tf
# locals {
# #   k8s_service_account_name      = "iam-role-test"
# #   k8s_service_account_namespace = "default"

#   # Get the EKS OIDC Issuer without https:// prefix
#   eks_oidc_issuer = trimprefix(aws_eks_cluster.eks.identity[0].oidc[0].issuer, "https://")

# }
# data "aws_region" "current" {
#     name = "us-east-1"
# }

# data "external" "thumbprint" {
#   program = ["thumbprint.sh", data.aws_region.current.name]
# }

resource "aws_eks_addon" "addon" {
  cluster_name      = aws_eks_cluster.eks.name
  addon_name        = "aws-ebs-csi-driver"
  addon_version     = "v1.11.2-eksbuild.1" #e.g., previous version v1.8.7-eksbuild.2 and the new version is v1.8.7-eksbuild.3
  resolve_conflicts = "PRESERVE"
  # service_account_role_arn = local.k8s_service_account_name

}

# data "tls_certificate" "example" {
#   url = aws_eks_cluster.eks.identity[0].oidc[0].issuer
# }

# resource "aws_iam_openid_connect_provider" "example" {
#   client_id_list  = ["sts.amazonaws.com"]
#   thumbprint_list = [data.tls_certificate.example.certificates[0].sha1_fingerprint]
#   url             = aws_eks_cluster.eks.identity[0].oidc[0].issuer
# }

resource "aws_iam_role" "test_role" {
  name = "test_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}