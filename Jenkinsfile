pipeline {
    agent any

    stages {
        stage('Setup SSH') {
            steps {
                // Trust GitHub host inside container
                sh 'mkdir -p ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts'
            }
        }

        stage('Checkout') {
            steps {
                // Use SSH key credential to fetch repo
                sshagent(['github-ssh']) {  // Replace 'github-ssh' with your Jenkins credential ID
                    sh 'git clone -b main git@github.com:purework1947/MYCICDPROJECT.git'
                }
            }
        }

        stage('Run Cypress in Docker') {
            steps {
                sh 'docker build -t cypress-tests MYCICDPROJECT'
                sh 'docker run --rm cypress-tests'
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'MYCICDPROJECT/cypress/screenshots/**, MYCICDPROJECT/cypress/videos/**', allowEmptyArchive: true
        }
    }
}
