locals {
  local_oidc_url = flatten(aws_eks_cluster.eks.identity[*].oidc[*].issuer)[0]
}

resource "aws_eks_addon" "addon" {
  cluster_name  = aws_eks_cluster.eks.name
  addon_name    = "aws-ebs-csi-driver" # Name of Addon i used
  addon_version = "v1.11.2-eksbuild.1" # e.g., previous version v1.8.7-eksbuild.2 and the new version is v1.8.7-eksbuild.3
  # service_account_role_arn = local.k8s_service_account_name
  depends_on = [
    aws_iam_role_policy_attachment.ebs_csi_plugin_policy_attachment
  ]
}

resource "aws_iam_role" "ebs_csi_plugin_role" {
  name = "AmazonEKS_EBS_CSI_DriverRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.local_oidc_url}"
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${local.local_oidc_url}:sub" = "system:serviceaccount:${var.namespace}:${var.service_account_name}"
          }
        }
      }
    ]
  })
}

data "aws_caller_identity" "current" {}

resource "aws_iam_role_policy_attachment" "ebs_csi_plugin_policy_attachment" {
  # policy_arn = "arn:aws:iam::aws:policy/AmazonEBSCSIDriverPolicy"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.ebs_csi_plugin_role.name
}