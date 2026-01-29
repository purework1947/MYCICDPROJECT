pipeline {
    agent any

    environment {
        CYPRESS_RESULTS = "${WORKSPACE}/allure-results"
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Cypress Docker Image') {
            steps {
                sh '''
                docker build --no-cache -t mycicdproject .
                '''
            }
        }

        stage('Run Cypress Tests') {
            steps {
                sh '''
                # Clean previous results
                rm -rf allure-results
                mkdir -p allure-results

                # Run Cypress inside Docker and mount results folder
                docker run --rm -v $CYPRESS_RESULTS:/app/allure-results mycicdproject
                '''
            }
        }

        stage('Publish Allure Report') {
            steps {
                allure([
                    includeProperties: false,
                    results: [[path: 'allure-results']]
                ])
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}
