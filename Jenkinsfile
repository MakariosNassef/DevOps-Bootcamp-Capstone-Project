pipeline {
    agent any
    stages {
        stage('Checkout external proj') {
            steps {
                git url: 'https://github.com/MakariosNassef/DevOps-Bootcamp-Capstone-Project.git', branch: 'main' , credentialsId: 'git-credential'
            }
        }
        stage('Build Docker image Python app and push to ecr') {
            steps{
                script {
                    sh '''
                    pwd
                    cd $PWD/flask_app/FlaskApp/
                    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 705434271522.dkr.ecr.us-east-1.amazonaws.com
                    docker build -t python_app:app_"$BUILD_NUMBER" .
                    docker tag python_app:app_"$BUILD_NUMBER" 705434271522.dkr.ecr.us-east-1.amazonaws.com/python_app:app_"$BUILD_NUMBER"
                    docker push 705434271522.dkr.ecr.us-east-1.amazonaws.com/python_app:app_"$BUILD_NUMBER"
                    echo "Docker Cleaning up"
                    docker rmi 705434271522.dkr.ecr.us-east-1.amazonaws.com/python_app:app_"$BUILD_NUMBER"
                    '''
                }
            }
        }
        stage('Build Docker image mysql and push to ecr') {
            steps{
                script {
                    sh '''
                    pwd
                    cd $PWD/flask_app/db/
                    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 705434271522.dkr.ecr.us-east-1.amazonaws.com
                    docker build -t python_db:db_"$BUILD_NUMBER" .
                    docker tag python_db:db_"$BUILD_NUMBER" 705434271522.dkr.ecr.us-east-1.amazonaws.com/python_db:db_"$BUILD_NUMBER"
                    docker push 705434271522.dkr.ecr.us-east-1.amazonaws.com/python_db:db_"$BUILD_NUMBER"
                    echo "Docker Cleaning up"
                    docker rmi 705434271522.dkr.ecr.us-east-1.amazonaws.com/python_db:db_"$BUILD_NUMBER"
                    '''
                }
            }
        }

        stage('Apply Kubernetes files') {
            steps{
                // withKubeConfig([credentialsId: 'token-eks', serverUrl: 'https://D4D5B42935A6DD8ECD6B3991146B1233.gr7.us-east-1.eks.amazonaws.com']) {
                script {
                    sh '''
                    sed -i \"s|image:.*|image: 705434271522.dkr.ecr.us-east-1.amazonaws.com/python_app:app_"$BUILD_NUMBER"|g\" `pwd`/kubernetes_manifest_file/deployment_flaskapp.yml
                    sed -i \"s|image:.*|image: 705434271522.dkr.ecr.us-east-1.amazonaws.com/python_db:db_"$BUILD_NUMBER"|g\" `pwd`/kubernetes_manifest_file/deployment_flaskapp.yml
                    aws eks update-kubeconfig --region us-east-1 --name eks
                    kubectl apply -f $PWD/kubernetes_manifest_file
                    '''
                }
                //}    
            }
        }

    }
}

