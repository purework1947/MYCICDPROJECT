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
                sshagent(['-----BEGIN OPENSSH PRIVATE KEY----- b3BlbnNzaC1rZXktdjEAAAAACmFlczI1Ni1jdHIAAAAGYmNyeXB0AAAAGAAAABDRMfFyeW 0dsqfb4CJlx1Q8AAAAGAAAAAEAAAAzAAAAC3NzaC1lZDI1NTE5AAAAIN5fJFS3NvIx24u0 wmkhgmNTbLC7IcF5z5S0KJJBtuf8AAAAoDYOfBeS8xvvKCj+suP4RcyLEkEPGzmf4tAc3i U9BalLithNTXr2DKHcGyx3Elj35if/VPjozFVRIhtnI6vTFFOsanjMISOOZ7B00I3jLIlO XDNOKd6yMUmkxJkZmkWkw7/f71VYfIxSf/aNdZvmI/tKBxCXt6R6G9vkMzUPqbLCPaoE3e mMN9SfsiOzxGR0INY9d6SORvbzBjh7RCnCf7c= -----END OPENSSH PRIVATE KEY-----']) {  // Replace 'github-ssh' with your Jenkins credential ID
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
