pipeline {
    agent any

    environment {
        ALLURE_RESULTS = "${WORKSPACE}/allure-results"
        NO_COLOR = "1"
        FORCE_COLOR = "0"
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

        stage('Run Cypress Tests (todo.cy.js)') {
            steps {
                sh '''
                  rm -rf allure-results
                  mkdir -p allure-results

                  docker run --rm \
  -e NO_COLOR=1 \
  -e FORCE_COLOR=0 \
  -e CYPRESS_allure=true \
  -e CYPRESS_allureResultsPath=/app/allure-results \
  -v $ALLURE_RESULTS:/app/allure-results \
  mycicdproject \
  cypress run --spec "cypress/e2e/1-getting-started/todo.cy.js"

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
