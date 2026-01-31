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
# Clean previous results
rm -rf allure-results allure-report
mkdir -p allure-results allure-report

# Run Cypress (Docker CMD already generates Allure report)
docker run --rm \\
  -e NO_COLOR=$NO_COLOR \\
  -e FORCE_COLOR=$FORCE_COLOR \\
  -v $WORKSPACE/allure-results:/app/allure-results \\
  -v $WORKSPACE/allure-report:/app/allure-report \\
  $IMAGE_NAME

# Fix permissions for Jenkins
chmod -R 777 allure-results allure-report

echo "Allure Results:"
ls -lah allure-results
echo "Allure Report:"
ls -lah allure-report
"""
            }
        }

        stage('Publish Allure Report') {
            steps {
                echo "Publishing Allure report..."
                allure([
                    results: [[path: 'allure-res]()]()
