pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "asifuserdocker/demo-jenkins"
        CONTAINER_NAME = "demo-container"
    }

    stages {
        stage("Checkout") {
            steps {
                checkout scm
            }
        }

        stage("Install & Build") {
            steps {
                // Combine into one directory context to ensure Node 20+ is used
                dir('my-app') {
                    sh 'npm install'
                    sh 'npm run build'
                }
            }
        }

        stage("Build Docker Image") {
            steps {
                // Ensure Docker build happens INSIDE the my-app folder where Dockerfile lives
                dir('my-app') {
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage("Login to DockerHub") {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker-creds', // Make sure this ID exists in Jenkins
                    usernameVariable: 'DOCKER_USER', // This is the VARIABLE name, not your username
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    // Use the variables defined above
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage("Push & Deploy") {
            steps {
                sh "docker push ${DOCKER_IMAGE}"
                sh """
                docker stop ${CONTAINER_NAME} || true
                docker rm ${CONTAINER_NAME} || true
                docker run -d -p 80:80 --name ${CONTAINER_NAME} ${DOCKER_IMAGE}
                """
            }
        }
    }

    post {
        success { echo "✅ Pipeline executed successfully" }
        failure { echo "❌ Pipeline execution failed" }
    }
}
