pipeline {
    agent any

    tools {
        jdk 'jdk11'
    }

    stages {

        stage('Checkout') {
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
                  rm -rf allure-results
                  mkdir -p allure-results

                  docker run --rm \
                    -v "$WORKSPACE/allure-results:/app/allure-results" \
                    mycicdproject
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
}
