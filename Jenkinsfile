pipeline {
    agent { label 'abdullah' }

    environment {
        DOCKER_IMAGE = "asifuserdocker/demo-jenkins"
        CONTAINER_NAME = "demo-container"
    }

    stages {

        stage("Checkout") {
            steps {
                git branch: "main", url: "https://github.com/shaikasif-2881/Demo_jenkins.git"
            }
        }

        stage("Install Dependencies") {
            steps {
                sh '''
                cd my-app
                npm install
                '''
            }
        }

        stage("Build Application") {
            steps {
                sh '''
                cd my-app
                npm run build
                '''
            }
        }

        stage("Build Docker Image") {
            steps {
                sh '''
                cd my-app
                docker build -t $DOCKER_IMAGE .
                '''
            }
        }

        stage("Login to DockerHub") {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker-creds',
                    usernameVariable: 'asifuserdocker',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage("Push Docker Image") {
            steps {
                sh 'docker push $DOCKER_IMAGE'
            }
        }

        stage("Deploy Container") {
            steps {
                sh '''
                docker stop $CONTAINER_NAME || true
                docker rm $CONTAINER_NAME || true
                docker run -d -p 80:80 --name $CONTAINER_NAME $DOCKER_IMAGE
                '''
            }
        }
    }

    post {
        always {
            echo "======== ALWAYS ========"
        }
        success {
            echo "✅ Pipeline executed successfully"
        }
        failure {
            echo "❌ Pipeline execution failed"
        }
    }
}
