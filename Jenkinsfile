pipeline {
    agent any

    environment {
        IMAGE_NAME = "mycicdproject"
        ALLURE_RESULTS = "${WORKSPACE}/allure-results"
        ALLURE_REPORT  = "${WORKSPACE}/allure-report"
        NO_COLOR = "1"
        FORCE_COLOR = "0"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Cypress Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME -f Dockerfile.cypress .'
            }
        }

        stage('Run Cypress Tests') {
            steps {
                sh '''
                  rm -rf allure-results allure-report
                  mkdir -p allure-results allure-report

                  docker run --rm \
                    -e NO_COLOR=1 \
                    -e FORCE_COLOR=0 \
                    -e CYPRESS_allure=true \
                    -e CYPRESS_allureResultsPath=/app/allure-results \
                    -v $WORKSPACE/allure-results:/app/allure-results \
                    -v $WORKSPACE/allure-report:/app/allure-report \
                    $IMAGE_NAME || true

                  echo "Allure results:"
                  ls -lah allure-results
                '''
            }
        }

        stage('Publish Allure Report') {
            steps {
                allure([
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
