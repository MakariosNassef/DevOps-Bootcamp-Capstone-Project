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
                    docker build -t python_app:db_"$BUILD_NUMBER" .
                    docker tag python_app:db_"$BUILD_NUMBER" 705434271522.dkr.ecr.us-east-1.amazonaws.com/python_app:db_"$BUILD_NUMBER"
                    docker push 705434271522.dkr.ecr.us-east-1.amazonaws.com/python_app:db_"$BUILD_NUMBER"
                    '''
                }
            }
        }

        // stage('Cleaning up') {
        //     steps{
        //         sh "docker rmi $registry:$BUILD_NUMBER"
        //         aws eks update-kubeconfig --region us-east-1 --name eks
        //     }
        // }

        // stage('Apply Deployment file for the python App') {
        //     steps{
        //         sh '''
        //         kubectl apply -f $PWD/kubernetes_manifest_file
        //         kubectl get svc flask-service
        //         '''
        //     }
        // }

        stage('Apply Kubernetes files') {
            steps{
                withKubeConfig([credentialsId: 'user1', serverUrl: 'https://api.k8s.my-company.com']) {
                script {
                    sh ''' 
                    kubectl apply -f $PWD/kubernetes_manifest_file
                    '''
                }
                }    
            }
        }

    }
}
