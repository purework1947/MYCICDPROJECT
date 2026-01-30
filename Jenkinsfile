pipeline {
    agent any

    environment {
        CYPRESS_RESULTS = "${WORKSPACE}/allure-results"
        TERM = "xterm"
        NO_COLOR = "1"
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
                    -v $CYPRESS_RESULTS:/app/allure-results \
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

    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}
