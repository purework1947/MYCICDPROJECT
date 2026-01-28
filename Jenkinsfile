pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "cypress-tests"
    }

    stages {
        stage('Checkout') {
            steps {
                // Use SSH and Jenkins credentials
                git url: 'git@github.com:purework1947/MYCICDPROJECT.git', 
                    branch: 'main', 
                    credentialsId: 'sshkey'
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
                    docker run --rm -v ${WORKSPACE}:/app -w /app ${DOCKER_IMAGE} \
                    npx cypress run --spec "cypress/e2e/1-getting-started/todo.cy.js"
                    """
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'cypress/videos/**', allowEmptyArchive: true
            archiveArtifacts artifacts: 'cypress/screenshots/**', allowEmptyArchive: true
        }
        success {
            echo 'Tests passed!'
        }
        failure {
            echo 'Tests failed!'
        }
    }
}
