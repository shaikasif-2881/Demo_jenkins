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
                echo "Running main script..."
                ./script.sh
                '''
            }
        }

        stage("Test") {
            steps {
                sh '''
                echo "Running basic tests..."

                # Example test condition
                if [ -f script.sh ]; then
                    echo "Test Passed "
                else
                    echo "Test Failed "
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
