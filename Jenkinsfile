pipeline {
    agent any

    environment {
        DOCKER_BUILDKIT = '1'
    }

    stages {
        stage('Checkout') {
            steps {
                sshagent(credentials: ['github-ssh']) {
                    sh '''
                      mkdir -p ~/.ssh
                      ssh-keyscan github.com >> ~/.ssh/known_hosts
                      git clone git@github.com:purework1947/MYCICDPROJECT.git || true
                    '''
                }
            }
        }

        stage('Build Cypress Docker') {
            steps {
                sh '''
                  docker build -t cypress-tests .
                '''
            }
        }

        stage('Run Cypress Tests') {
            steps {
                sh '''
                  docker run --rm cypress-tests
                '''
            }
        }
    }
}
