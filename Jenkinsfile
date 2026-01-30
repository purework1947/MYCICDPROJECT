pipeline {
    agent any

    environment {
        ALLURE_RESULTS = "${WORKSPACE}/allure-results"
        NO_COLOR = "1"       // disable ANSI colors
        FORCE_COLOR = "0"    // ensure Node/Cypress doesn't force colors
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Cypress Docker Image') {
            steps {
                sh 'docker build -t mycicdproject .'
            }
        }

        stage('Run Cypress Tests') {
            steps {
                sh '''
          # Clean previous results
          rm -rf allure-results
          mkdir -p allure-results

          # Run Cypress Docker container
          docker run --rm \
            -e NO_COLOR=1 \
            -e FORCE_COLOR=0 \
            -v $ALLURE_RESULTS:/app/allure-results \
            mycicdproject

          # Debug: list files
          echo "Allure results content:"
          ls -lah allure-results
        '''
            }
        }

        stage('Publish Allure Report') {
            steps {
                allure([
                    includeProperties: false,
                    results: [[path: 'allure-results']],
                    // Link to the Allure CLI installation in Jenkins
                    commandline: tool(
                        name: 'Allure',
                        type: 'ru.yandex.qatools.allure.jenkins.tools.AllureCommandlineInstallation'
                    )
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
