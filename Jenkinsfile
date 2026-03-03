# Jenkinsfile - SWE645 HW2 CI/CD Pipeline
# Automates: build Docker image → push to DockerHub → deploy to Kubernetes

pipeline {
    agent any

    environment {
        DOCKERHUB_PASS  = credentials('docker-pass')
        DOCKERHUB_USER  = 'akshatabora'
        APP_NAME        = 'studentsurvey645'
        IMAGE_TAG       = "${BUILD_TIMESTAMP}"
        FULL_IMAGE      = "${DOCKERHUB_USER}/${APP_NAME}:${IMAGE_TAG}"
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${FULL_IMAGE} ."
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    sh "docker login -u ${DOCKERHUB_USER} -p ${DOCKERHUB_PASS}"
                    sh "docker push ${FULL_IMAGE}"
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh """
                        kubectl set image deployment/simple-webapp \
                            simple-webapp=${FULL_IMAGE} \
                            --kubeconfig /root/.kube/config
                    """
                }
            }
        }

    }

    post {
        success {
            echo "Deployed successfully: ${FULL_IMAGE}"
        }
        failure {
            echo "Pipeline failed. Check the logs above."
        }
    }
}
