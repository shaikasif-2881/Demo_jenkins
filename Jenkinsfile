pipeline {
    agent any

    stages {

        stage("Checkout") {
            steps {
                checkout scm
            }
        }

        stage("Prepare") {
            steps {
                sh '''
                echo "Preparing environment..."
                chmod +x script.sh
                '''
            }
        }

        stage("Run Script") {
            steps {
                sh '''
                echo "Running script..."
                ./script.sh
                '''
            }
        }

        stage("Test") {
            steps {
                sh '''
                echo "Running tests..."

                if [ -f script.sh ]; then
                    echo "Test Passed ✅"
                else
                    echo "Test Failed ❌"
                    exit 1
                fi
                '''
            }
        }

        stage("Deploy") {
            when {
                anyOf {
                    branch 'dev'
                    branch 'main'
                }
            }
            steps {
                script {

                    if (env.BRANCH_NAME == 'dev') {
                        echo "🚀 Deploying to STAGING"
                        sh '''
                        mkdir -p /tmp/staging
                        cp script.sh /tmp/staging/
                        echo "Deployed to STAGING"
                        '''
                    }

                    if (env.BRANCH_NAME == 'main') {
                        echo "🚀 Deploying to PRODUCTION"
                        sh '''
                        mkdir -p /tmp/production
                        cp script.sh /tmp/production/
                        echo "Deployed to PRODUCTION"
                        '''
                    }

                    if (env.BRANCH_NAME == 'test') {
                        echo "🧪 Test branch - No deployment"
                    }
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline completed"
        }
        success {
            echo "SUCCESS ✅"
        }
        failure {
            echo "FAILED ❌"
        }
    }
}
