pipeline {
    agent any

    environment {
        IMAGE_NAME = "registry.gitlab.com/mon-utilisateur/move-to-cloud"
        KUBE_CONFIG = credentials('KUBE_CONFIG')
    }

    stages {
        stage('Build') {
            steps {
                script {
                    sh 'docker build -t $IMAGE_NAME:$BUILD_NUMBER .'
                    sh 'docker login -u "$DOCKER_USER" -p "$DOCKER_PASSWORD" registry.gitlab.com'
                    sh 'docker push $IMAGE_NAME:$BUILD_NUMBER'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh 'echo "$KUBE_CONFIG" | base64 -d > kubeconfig.yaml'
                    sh 'export KUBECONFIG=kubeconfig.yaml'
                    sh 'kubectl apply -f k8s/deployment.yaml'
                    sh 'kubectl apply -f k8s/service.yaml'
                }
            }
        }
    }
}
