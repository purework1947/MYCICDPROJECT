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
                mkdir -p allure-report
                  docker run --rm \
                    -v "$WORKSPACE/allure-report:/app/allure-report" \
                    mycicdproject
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
