pipeline {
    agent any
    stages {
        stage('Checkout external proj') {
            steps {
                git url: 'https://github.com/MakariosNassef/DevOps-Bootcamp-Capstone-Project.git', branch: 'main' , credentialsId: 'git-credential'
                sh "ls -lat"
            }
        }
        stage('Build Docker image Python app and push to ecr') {
            steps{
                script {
                    sh '''
                    pwd
                    cd $PWD/DevOps-Bootcamp-Capstone-Project/flask_app/FlaskApp/
                    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 705434271522.dkr.ecr.us-east-1.amazonaws.com
                    docker build -t python_app:"$BUILD_NUMBER" .
                    docker tag python_app:"$BUILD_NUMBER" 705434271522.dkr.ecr.us-east-1.amazonaws.com/python_app:"$BUILD_NUMBER"
                    docker push 705434271522.dkr.ecr.us-east-1.amazonaws.com/python_app:"$BUILD_NUMBER"
                    '''
                }
            }
        }
        stage('Build Docker image mysql and push to ecr') {
            steps{
                script {
                    sh '''
                    pwd
                    cd $PWD/DevOps-Bootcamp-Capstone-Project/flask_app/db/
                    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 705434271522.dkr.ecr.us-east-1.amazonaws.com
                    docker build -t mysql:"$BUILD_NUMBER" .
                    docker tag mysql:"$BUILD_NUMBER" 705434271522.dkr.ecr.us-east-1.amazonaws.com/mysql:"$BUILD_NUMBER"
                    docker push 705434271522.dkr.ecr.us-east-1.amazonaws.com/mysql:"$BUILD_NUMBER"
                    '''
                }
            }
        }

        // stage('Cleaning up') {
        //     steps{
        //         sh "docker rmi $registry:$BUILD_NUMBER"
        //     }
        // }
        }

}
