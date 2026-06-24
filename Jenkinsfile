pipeline {
    agent any

    environment {
        APP_NAME = 'fundme'
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Stage 1: Pulling latest code from GitHub...'
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo 'Stage 2: Building application with Maven...'
                sh 'chmod +x mvnw'
                sh './mvnw clean package -DskipTests'
            }
        }

        stage('Test') {
            steps {
                echo 'Stage 3: Running JUnit tests...'
                sh './mvnw test'
            }
        }

        stage('Docker Build') {
            steps {
                echo 'Stage 4: Building Docker image...'
                sh 'docker build -t fundme:latest .'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Stage 5: Deploying with Docker Compose...'
                sh 'docker compose down || true'
                sh 'docker compose up -d'
            }
        }
    }

    post {
        success {
            echo 'Pipeline SUCCESS! FundMe app deployed successfully!'
        }
        failure {
            echo 'Pipeline FAILED! Check the logs above.'
        }
    }
}