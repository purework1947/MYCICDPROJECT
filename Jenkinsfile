pipeline {
    agent any

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Cypress Image') {
            steps {
                sh 'docker build -t mycicdproject .'
            }
        }

        stage('Run Cypress Tests') {
            steps {
                sh '''
                docker run --name cypress-run mycicdproject
                '''
            }
            post {
                always {
                    sh '''
                    docker cp cypress-run:/app/allure-report ./allure-report || true
                    docker rm cypress-run || true
                    '''
                }
            }
        }

        stage('Publish Allure Report') {
            steps {
                publishHTML([
                    reportDir: 'allure-report',
                    reportFiles: 'index.html',
                    reportName: 'Cypress Allure Report'
                ])
            }
        }
    }
}
