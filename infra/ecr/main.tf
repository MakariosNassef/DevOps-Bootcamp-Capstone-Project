resource "aws_ecr_repository" "aws_ecr" {
  for_each             = toset(var.ecr_names)
  name                 = each.value # var.ecr_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}


data "aws_iam_policy_document" "aws_ecr_policy" {
  statement {
    sid    = "new policy"
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeRepositories",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
      "ecr:DeleteRepository",
      "ecr:BatchDeleteImage",
      "ecr:SetRepositoryPolicy",
      "ecr:DeleteRepositoryPolicy",
    ]
  }
}

resource "aws_ecr_repository_policy" "aws_ecr_policy" {
  for_each   = toset(var.ecr_names)
  repository = each.value
  # repository = aws_ecr_repository.aws_ecr.name
  policy = data.aws_iam_policy_document.aws_ecr_policy.json
}



data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_partition" "current" {}

resource "aws_ecr_registry_policy" "example" {
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "testpolicy",
        Effect = "Allow",
        Principal = {
          "AWS" : "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action = [
          "ecr:ReplicateImage"
        ],
        Resource = [
          "arn:${data.aws_partition.current.partition}:ecr:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:repository/*"
        ]
      }
    ]
  })
}