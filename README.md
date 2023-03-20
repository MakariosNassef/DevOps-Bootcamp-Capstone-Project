# 🎉 DevOps-Bootcamp-Capstone-Project 🎉

## ✨ Introduction

The DevOps Bootcamp Capstone Project aims to create a fully automated CI/CD pipeline for a web application running on Kubernetes. The project utilizes various tools and technologies such as Terraform, Ansible, Docker, and Kubernetes to achieve the objective.

![image](https://user-images.githubusercontent.com/28235504/226341088-c1baa419-ec1d-4258-807c-d81d61ab9d1c.png)

## Prerequisites:
- ✅  Git
- ✅  Terraform
- ✅  Ansible
- ✅  Docker 
- ✅  Docker Compose
- ✅  Kubernetes
- ✅  AWS
- ✅  Jenkins


# 🏗️ To set up the project, follow these steps:

- Clone the project repository to your local machine.
- Navigate to the project directory.
- Run Terraform to create VPC with 3 Subnet in 2 AZs, EKS cluster with two nodes, an EC2 machine for Jenkins, and an ECR.
    - To initialize Terraform: ``` terraform init ```
    - To execute a Terraform plan: ``` terraform plan ```
    - To apply the Terraform plan and build the infrastructure: ``` terraform apply ```

- Use Ansible to install and configure Jenkins, including necessary plugins.
    - ``` ansible-playbook -i '${aws_instance.jenkins-instance.public_ip},' -u ubuntu --private-key /PATH/.pem Ansible_PATH/main.yml ```

- RUN docker compose up in flask_app dir for the code and database to run app.
    - ``` docker compose up ```

- After completing the necessary steps outlined in the previous sections,You can run the pipeline.



## Tasks Completed
- Used Terraform to create VPC with 3 Subnet in 2 AZs,EKS cluster with two nodes, an EC2 machine for Jenkins, ECR and run Ansible playbook for configure jenkins and plugins.
- Used Ansible to install and configure Jenkins, including necessary plugins and AWS and Kubernetes credentials.
- Forked the MySQL-and-Python repository and created a Docker image for the code.
- Created a Docker compose file for the code and database to run.
- Created Kubernetes deployment files for the Python code and statefulset files for MySQL, with PV and PVCs. Added services, configmaps, and secrets for the code, and used an NGINX controller for ingress.
- Configured Jenkins using pipeline as a code to build from GitHub on every push on all branches (GitHub webhooks) to integrate with Jenkins.
- Build the CI/CD Pipeline using Jenkins.
    - Checkout external project 🙈
    - build new Docker images
    - push the image to ECR
    - add image to the yml files app and database
    - 🚀 Deploy Kubernetes manifest files. 
    - 🚀 the pipeline is configured to output the URL to the website.




## Conclusion
The successful completion of this project highlights the importance of DevOps practices in modern software development. By automating the deployment process, teams can save time, reduce errors, and improve overall productivity. The use of tools like Terraform, Ansible, Docker, and Kubernetes streamlines the process of deploying and scaling applications, making it easier for teams to manage complex infrastructures.


## Challenges Faced
During the project, some challenges were encountered, including 
1- Ansible playbook for configure jenkins plugins.
2- configuring EC2 integrating it with EKS. Initially, only the creator of the Amazon EKS cluster has system:masters permissions to configure the cluster. To extend system:masters permissions to other users and roles, you must add the aws-auth ConfigMap to the configuration of the Amazon EKS cluster. The ConfigMap allows other IAM entities, such as users and roles, to access the Amazon EKS cluster.

- ``` kubectl edit configmap aws-auth --namespace kube-system ```
- ``` aws eks update-kubeconfig --name eks-cluster-name —region aws-region —profile ```
- ``` kubectl config view --minify ```
- https://aws.amazon.com/premiumsupport/knowledge-center/eks-api-server-unauthorized-error/
- https://aws.amazon.com/premiumsupport/knowledge-center/amazon-eks-cluster-access/
- https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html

## links that help me on this project
- Creating the Amazon EBS CSI driver IAM role for service accounts 
https://docs.aws.amazon.com/eks/latest/userguide/csi-iam-role.html
- Creating an IAM OIDC provider for your cluster 
https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html
- Supported Versions table 
https://github.com/kubernetes/ingress-nginx#supported-versions-table
