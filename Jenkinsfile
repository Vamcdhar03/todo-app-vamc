pipeline {
    agent any
    tools {
        dockerTool 'DOCKER'
        git 'Default'
        jdk 'JAVA'
        maven 'MAVEN'
    }
    stages {
        stage('git checkout') {
            steps {
                git 'https://github.com/Vamcdhar03/todo-app-vamc.git'
            }
        }
        stage('Maven') {
            steps {
                sh 'mvn clean install package'
            }
        }
        stage('Docker build & push') {
            steps {
                sh 'aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 084056488581.dkr.ecr.ap-south-1.amazonaws.com'
                sh 'docker build -t vamc/todo-app:latest .'
                sh 'docker tag vamc/todo-app:latest 084056488581.dkr.ecr.ap-south-1.amazonaws.com/vamc/todo-app:latest'
                sh 'docker push 084056488581.dkr.ecr.ap-south-1.amazonaws.com/vamc/todo-app:latest'
            }
        }
        stage('Kubernetes upload') {
            steps {
                sh '''
                CREDENTIALS=$(aws sts assume-role --role-arn arn:aws:iam::084056488581:role/KubectlRole --role-session-name codebuild-kubectl --duration-seconds 900)
                export AWS_ACCESS_KEY_ID="$(echo ${CREDENTIALS} | jq -r '.Credentials.AccessKeyId')"
                export AWS_SECRET_ACCESS_KEY="$(echo ${CREDENTIALS} | jq -r '.Credentials.SecretAccessKey')"
                export AWS_SESSION_TOKEN="$(echo ${CREDENTIALS} | jq -r '.Credentials.SessionToken')"
                export AWS_EXPIRATION=$(echo ${CREDENTIALS} | jq -r '.Credentials.Expiration')
                aws eks update-kubeconfig --name demo --region ap-south-1
                kubectl apply -f manifests/.
                kubectl get svc
                '''
            }
        }
    }
}
