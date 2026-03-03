pipeline {
    agent any

    environment {
        DOCKERHUB_CREDS  = credentials('docker-pass')
        DOCKERHUB_USER  = 'akshatabora'
        APP_NAME        = 'studentsurvey645'
        IMAGE_TAG       = "${BUILD_NUMBER}"
        FULL_IMAGE      = "${DOCKERHUB_USER}/${APP_NAME}:${IMAGE_TAG}"
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Building the web app into a docker image') {
            steps {
                script {
                    sh "docker build -t ${FULL_IMAGE} ."
                }
            }
        }

        stage('Pushing Image to Dockerhub') {
            steps {
                script {
                    sh "echo ${DOCKERHUB_CREDS_PSW} | docker login -u ${DOCKERHUB_CREDS_USR} --password-stdin"
                    sh "docker push ${FULL_IMAGE}"
                }
            }
        }

        stage('Deploying image to cluster on Rancher') {
            steps {
                script {
                    sh """
                        kubectl set image deployment/simple-webapp \
                            simple-webapp=${FULL_IMAGE} \
                            --kubeconfig /var/lib/jenkins/.kube/config
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
