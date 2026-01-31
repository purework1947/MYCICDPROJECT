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
                echo "Checking out source code..."
                checkout scm
            }
        }

        stage('Build Cypress Docker Image') {
            steps {
                echo "Building Cypress Docker image..."
                sh 'docker build -t $IMAGE_NAME -f Dockerfile .'
            }
        }

        stage('Run Cypress Tests') {
            steps {
                echo "Running Cypress tests inside Docker container..."
                sh """#!/bin/bash
# Run Cypress tests in Docker container
docker run --rm \\
  -v $ALLURE_RESULTS:/app/allure-results \\
  -v $ALLURE_REPORT:/app/allure-report \\
  -v $WORKSPACE/cypress:/app \\
  $IMAGE_NAME npx cypress run --spec cypress/e2e/1-getting-started/todo.cy.js

# Generate Allure report in Docker container
docker run --rm \\
  -v $ALLURE_RESULTS:/app/allure-results \\
  -v $ALLURE_REPORT:/app/allure-report \\
  $IMAGE_NAME npx allure generate /app/allure-results -o /app/allure-report

# Fix permissions for Jenkins
chmod -R 777 $ALLURE_RESULTS $ALLURE_REPORT

echo "Allure Results:"
ls -lah $ALLURE_RESULTS
echo "Allure Report:"
ls -lah $ALLURE_REPORT
"""
            }
        }

        stage('Publish Allure Report') {
            steps {
                echo "Publishing Allure report..."
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
