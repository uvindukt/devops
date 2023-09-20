pipeline {
    agent any
    tools{
        maven 'maven_3_9_4'
    }
    stages{
        stage('Build Maven'){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/uvindukt/devops.git']]])
                bat 'mvn clean install'
            }
        }
        stage('Build Docker Image'){
            steps{
                script{
                    bat 'docker build -t uvindukt/devops .'
                }
            }
        }
        stage('Push Image to Dockerhub'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]) {
                        bat 'docker login -u uvindukt -p %dockerhubpwd%'
                    }
                   bat 'docker push uvindukt/devops'
                }
            }
        }
        stage ('Sonar Scan') {
            steps {
               withSonarQubeEnv(installationName: 'SonarQube', credentialsId: 'SonarQube Token') {
                bat 'mvn clean package sonar:sonar'
                }
            }
        }
    }
}