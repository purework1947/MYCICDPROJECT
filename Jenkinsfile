pipeline {
    agent any

    environment {
        ALLURE_RESULTS = "${WORKSPACE}/allure-results"
        NO_COLOR = "1"       // disable ANSI colors
        FORCE_COLOR = "0"    // ensure Node/Cypress don't force colors
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Cypress Image') {
            steps {
                sh 'docker build -t mycicdproject -f Dockerfile.cypress .'
            }
        }

        stage('Run Cypress Tests') {
            steps {
                sh '''
                  # Clean previous results
                  rm -rf allure-results
                  mkdir -p allure-results

                  # Run Cypress inside Docker with ANSI disabled
                  docker run --rm \
                    -e NO_COLOR=1 \
                    -e FORCE_COLOR=0 \
                    -v $ALLURE_RESULTS:/app/allure-results \
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
