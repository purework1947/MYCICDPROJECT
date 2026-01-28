pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "cypress-tests"
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/<YOUR-GITHUB-REPO>.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Run Cypress Tests') {
            steps {
                script {
                    sh """
                    docker run --rm -v \$PWD:/app -w /app ${DOCKER_IMAGE} \
                    npx cypress run --spec "cypress/e2e/1-getting-started/todo.cy.js"
                    """
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'cypress/videos/**, cypress/screenshots/**', allowEmptyArchive: true
        }
        success {
            echo 'Tests passed!'
        }
        failure {
            echo 'Tests failed!'
        }
    }
}
