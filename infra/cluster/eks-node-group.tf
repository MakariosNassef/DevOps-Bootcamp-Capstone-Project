resource "aws_iam_role" "nodes_general" { # Create IAM role for EKS Node Group
  name = "eks-node-group-general"         # The name of the role

  # The policy that grants an entity permission to assume the role.
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }, 
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy_general" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy" # The ARN of the policy you want to apply.
  role       = aws_iam_role.nodes_general.name                     # The role the policy should be applied to
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy_general" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy" # The ARN of the policy you want to apply.
  role       = aws_iam_role.nodes_general.name                # The role the policy should be applied to
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly" # The ARN of the policy you want to apply.
  role       = aws_iam_role.nodes_general.name                              # The role the policy should be applied to
}

resource "aws_eks_node_group" "nodes_general" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "nodes-general"
  node_role_arn   = aws_iam_role.nodes_general.arn
  subnet_ids = [
    var.PRIVATE_SUBNET_ID
  ]

  scaling_config { # Configuration block with scaling settings
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

  # Type of Amazon Machine Image (AMI) associated with the EKS Node Group.
  ami_type             = "AL2_x86_64" # Valid values: AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64
  capacity_type        = "ON_DEMAND"  # Valid values: ON_DEMAND, SPOT
  disk_size            = 20
  force_update_version = false
  instance_types       = ["t3.small"]

  labels = {
    role = "nodes-general"
  }
  version = "1.24" # Kubernetes version

  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy_general,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy_general,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
  ]
}

############################################



resource "aws_iam_policy" "eks_worknode_ebs_policy" {
  name = "Amazon_EBS_CSI_Driver"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:AttachVolume",
        "ec2:CreateSnapshot",
        "ec2:CreateTags",
        "ec2:CreateVolume",
        "ec2:DeleteSnapshot",
        "ec2:DeleteTags",
        "ec2:DeleteVolume",
        "ec2:DescribeInstances",
        "ec2:DescribeSnapshots",
        "ec2:DescribeTags",
        "ec2:DescribeVolumes",
        "ec2:DetachVolume"
      ],
      "Resource": "*"
    }
  ]
}
POLICY
}
# And attach the new policy
resource "aws_iam_role_policy_attachment" "worknode-AmazonEBSCSIDriver" {
  policy_arn = aws_iam_policy.eks_worknode_ebs_policy.arn
  role       = aws_iam_role.nodes_general.name
}