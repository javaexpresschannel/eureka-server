pipeline {
    agent any

    tools {
        maven "MAVEN"
    }

    stages {
        stage('Checkout') {
            steps {
               git branch: 'main',  url: 'https://github.com/javaexpresschannel/test1.git'
            }
        }

        stage('Compile') {
            steps {
                sh "mvn clean compile"
            }
        }

        stage('Build') {
            steps {
                sh "mvn package"
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t javaexpress/eureka-server:latest .'
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([string(credentialsId: 'DOCKER_HUB_PASSWORD', variable: 'PASSWORD')]) {
                    sh 'docker login -u javaexpress -p $PASSWORD'
                }
            }
        }

        stage('Docker Push') {
            steps {
                sh 'docker push javaexpress/eureka-server:latest'
            }
        }

        stage("Kubernetes Deployment") {
            steps {
                sh '''
                    echo "Deleting old deployment (if exists)..."
                    kubectl delete deployment eureka-server-deployment --ignore-not-found

                    echo "Waiting for cleanup..."
                    sleep 5

                    echo "Applying fresh deployment..."
                    kubectl apply -f eureka-server.yml

                    echo "Waiting for deployment to stabilize..."
                    sleep 10

                    echo "Checking rollout status..."
                    kubectl rollout status deployment eureka-server-deployment
                '''
            }
        }
    }
}
