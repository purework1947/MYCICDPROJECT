pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                sshagent(['github-ssh']) {  // This must match your Jenkins credential ID
                    sh 'git clone git@github.com:purework1947/MYCICDPROJECT.git'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t cypress-tests MYCICDPROJECT'
            }
        }

        stage('Run Cypress Tests') {
            steps {
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
