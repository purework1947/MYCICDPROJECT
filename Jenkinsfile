pipeline {
    agent any

    environment {
        IMAGE_NAME = "mycicdproject"
        ALLURE_RESULTS = "${WORKSPACE}/allure-results"
        ALLURE_REPORT  = "${WORKSPACE}/allure-report"
        NO_COLOR = "1"
        FORCE_COLOR = "0"
        SPEC = "cypress/e2e/1-getting-started/todo.cy.js"  // default spec, can override
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Cypress Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME -f Dockerfile .'
            }
        }

        stage('Run Cypress Tests') {
            steps {
                sh '''
                  # Clean old results
                  rm -rf allure-results allure-report
                  mkdir -p allure-results allure-report

                  # Run Cypress in Docker
                  docker run --rm \
                    -e NO_COLOR=$NO_COLOR \
                    -e FORCE_COLOR=$FORCE_COLOR \
                    -e CYPRESS_allure=true \
                    -e CYPRESS_allureResultsPath=/app/allure-results \
                    -e ALLURE_REPORT=/app/allure-report \
                    -e SPEC=$SPEC \
                    -v $WORKSPACE/allure-results:/app/allure-results \
                    -v $WORKSPACE/allure-report:/app/allure-report \
                    $IMAGE_NAME \
                    npx cypress run --spec $SPEC

                  # Generate Allure report
                  npx allure generate /app/allure-results -o /app/allure-report --clean

                  # Fix permissions
                  chmod -R 777 allure-results allure-report

                  # List results
                  echo "Allure results folder:"
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
