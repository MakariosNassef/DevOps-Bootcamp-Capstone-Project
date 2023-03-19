resource "aws_instance" "jenkins-instance" {
  ami = var.AMI
  tags = {
    Name = "jenkins-instance"
  }
  instance_type = var.INSTANCE_TYPE
  subnet_id     = var.PUBLIC_SUBNET_ID
  # Attach the instance profile to the EC2 instance
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  vpc_security_group_ids = [aws_security_group.ssh-allowed.id]

  # the Public SSH key
  key_name = var.KEY_PAIR

  # Installing Nginx
  user_data = var.USER_DATA

  connection {
    user        = var.EC2_USER
    private_key = file("${var.PRIVATE_KEY_PATH}")
  }
  depends_on = [
    aws_iam_role_policy_attachment.ECR_PullPush_role_policy_role,
  ]
}


resource "aws_iam_policy" "ECR_PullPush_role_policy" {
  name = "Amazon_ECR_PullPush_role_policy"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload",
                "ecr:PutImage"
            ],
            "Resource": "*"
        }
    ]
}
POLICY
}

resource "aws_iam_policy" "EKS_Full_access" {
  name = "Amazon_EKS_Full_access"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "eks:*",
            "Resource": "*"
        }
    ]
}
POLICY
}


resource "aws_iam_role" "ElasticContainerRegistry_ECR_PullPush" {
  # The name of the role
  name = "ECR_PullPush_role"

  # The policy that grants an entity permission to assume the role.
  # Used to access AWS resources that you might not normally have access to.
  # The role that Amazon EKS will use to create AWS resources for Kubernetes clusters
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

resource "aws_iam_role_policy_attachment" "EKS_Full_access_policy_role" {
  policy_arn = aws_iam_policy.EKS_Full_access.arn
  role       = aws_iam_role.ElasticContainerRegistry_ECR_PullPush.name
}

resource "aws_iam_role_policy_attachment" "ECR_PullPush_role_policy_role" {
  policy_arn = aws_iam_policy.ECR_PullPush_role_policy.arn
  role       = aws_iam_role.ElasticContainerRegistry_ECR_PullPush.name
}


resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.ElasticContainerRegistry_ECR_PullPush.name
}

resource "aws_security_group" "ssh-allowed" {
  vpc_id = var.MAIN_VPC_ID
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [var.EGRESS_CIDR]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.INGRESS_CIDER]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.INGRESS_CIDER]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.INGRESS_CIDER]
  }
  tags = {
    Name = "ssh-allowed"
  }
}

# resource "null_resource" "jenkins_install" {
#   provisioner "local-exec" {
#     #command = "ansible-playbook -i '${var.INSTANCE_PUBLIC_IP_OUTPUT_MODULE},' -u ubuntu --private-key /home/mac/Downloads/mac-keyPair.pem /home/mac/Desktop/DevOps-Bootcamp-Capstone-Project/ansible_jenkins_config/tasks/main.yml"
#     command = "ansible-playbook -i '${aws_instance.jenkins-instance.public_ip},' -u ubuntu --private-key /home/mac/Downloads/mac-keyPair.pem /home/mac/Desktop/DevOps-Bootcamp-Capstone-Project/ansible_jenkins_config/tasks/main.yml"
#   }
#   depends_on = [aws_instance.jenkins-instance, ]
# }