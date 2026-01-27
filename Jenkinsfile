pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                sshagent(['github-ssh']) {
                    sh 'git clone git@github.com:purework1947/MYCICDPROJECT.git'
                }
            }
        }

        stage('Build Cypress Docker') {
            steps {
                sh 'docker build -t cypress-tests .'
            }
        }

        stage('Run Cypress Tests') {
            steps {
                sh 'docker run --rm cypress-tests'
            }
        }
    }
}
