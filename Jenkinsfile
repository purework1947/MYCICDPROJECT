pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Run Cypress in Docker') {
            steps {
                sh 'docker build -t cypress-tests .'
                sh 'docker run --rm cypress-tests'
            }
        }
    }
}
