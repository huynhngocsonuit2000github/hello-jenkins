pipeline {
    agent any

    environment {
        REGISTRY = 'docker.io'
        IMAGE_NAME_BASE = 'huynhngocsonuit2000docker/hello-world'
        DOCKER_CREDENTIAL_ID = 'docker-us-pdw'
    }

    stages {

	stage('Prepare') {
            steps {
                script {
                    // Generate a unique image tag using the build number and timestamp
                    env.IMAGE_TAG = "${env.BUILD_NUMBER}-${new Date().format('yyyyMMddHHmmss')}"
                    env.IMAGE_NAME = "${env.IMAGE_NAME_BASE}:${env.IMAGE_TAG}"
                }
            }
        }


        stage('Build') {
            steps {
                script {
                    // Build the .NET project
                    dir('src') {
                        sh 'dotnet build --configuration Release'
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh 'docker build -t $REGISTRY/$IMAGE_NAME .'
                }
            }
        }
		
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry("https://index.docker.io/v1/", "${env.DOCKER_CREDENTIAL_ID}") {
                        // Push the Docker image to the registry
                        sh "docker push ${env.REGISTRY}/${env.IMAGE_NAME}"
                    }
                }
            }
        }

	stage('Deploy') {
            steps {
                script {
                    // Remove any existing container with the same name
                    sh "docker rm -f dotnet-hello-world || true"
                    
                    // Run the new container
                    sh "docker run -d --name dotnet-hello-world -p 5001:80 ${env.IMAGE_NAME}"
                }
            }
        }
    }


    post {
        always {
            // Clean up workspace
            cleanWs()
        }
    }
}

