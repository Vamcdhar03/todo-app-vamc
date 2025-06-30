pipeline {
    agent any
    tools {
  dockerTool 'DOCKER'
  git 'Default'
  jdk 'JAVA'
  maven 'MAVEN'
}
    stages {
        stage('Git checkout') {
            steps {
                git 'https://github.com/Vamcdhar03/todo-application-jsp-servlet-jdbc-mysql.git'
            }
        }
            stage('maven build') {
            steps {
                sh 'mvn clean install package'
            }
        }
        stage('docker build & push') {
            steps {
                sh 'docker login -u vamcdocker404 -p password'
                sh 'docker build -t vamcdocker404/todo-app .'
                sh 'docker push vamcdocker404/todo-app'
            }
        }
    }
}
