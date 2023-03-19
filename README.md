# DevOps-Bootcamp-Capstone-Project

formating
terraform fmt --recursive 

aws eks update-kubeconfig --region us-east-1 --name eks


kubectl port-forward deployment/jenkins 8080:8080

kubectl port-forward svc/NAMEOFthe srvice 5002:80


to push to ecr
1- Retrieve an authentication token and authenticate your Docker client to your registry. Use the AWS CLI: 
``` aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 705434271522.dkr.ecr.us-east-1.amazonaws.com ```

Note: If you receive an error using the AWS CLI, make sure that you have the latest version of the AWS CLI and Docker installed.
2- Build your Docker image using the following command. For information on building a Docker file from scratch see the instructions here . You can skip this step if your image is already built:
``` docker build -t aws_ecr . ```

3- After the build completes, tag your image so you can push the image to this repository:
``` docker tag aws_ecr:latest 705434271522.dkr.ecr.us-east-1.amazonaws.com/aws_ecr:latest ```

4- Run the following command to push this image to your newly created AWS repository:
``` docker push 705434271522.dkr.ecr.us-east-1.amazonaws.com/aws_ecr:latest ``` 



### Initially, only the creator of the Amazon EKS cluster has system:masters permissions to configure the cluster. To extend system:masters permissions to other users and roles, you must add the aws-auth ConfigMap to the configuration of the Amazon EKS cluster. The ConfigMap allows other IAM entities, such as users and roles, to access the Amazon EKS cluster.
``` kubectl edit configmap aws-auth --namespace kube-system ```
``` aws eks update-kubeconfig --name eks-cluster-name —region aws-region —profile ```
>> In my-profile
>> In machine to confirm 
``` kubectl config view --minify ```
resorses
https://aws.amazon.com/premiumsupport/knowledge-center/eks-api-server-unauthorized-error/
https://aws.amazon.com/premiumsupport/knowledge-center/amazon-eks-cluster-access/
https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html
