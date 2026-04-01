pipeline{
    agent any
    stages{
        stage("Checkout"){
            steps{
                checkout scm
            }

        }
        stage("Install Dependencies"){
             steps{
                sh "npm install"
             }  
            }
        stage("Build"){
             steps{
                sh "npm run build"
             }  
            }
        post{
                always{
                    echo "========always========"
                }
                success{
                    echo "========A executed successfully========"
                }
                failure{
                    echo "========A execution failed========"
                }
            }
        }
    }
}
