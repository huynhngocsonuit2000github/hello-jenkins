pipeline {
    agent any

    environment {
        REGISTRY = 'docker.io'
        IMAGE_NAME = 'huynhngocsonuit2000docker/hello-world:v1'
        DOCKER_CREDENTIAL_ID = 'docker-us-pdw'
    }

    stages {
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
		
	stage('Docker Login') {
    	    steps {
        	script {
            	    sh 'docker login -u huynhngocsonuit2000docker -p SOn01698182219 https://index.docker.io/v1/'
        	}
    	    }
	}

	stage('Test push') {
            steps {
                script {
                    sh 'docker push ${env.REGISTRY}/${env.IMAGE_NAME}'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry("https://${env.REGISTRY}", "${env.DOCKER_CREDENTIAL_ID}") {
                        // Push the Docker image to the registry
                        sh "docker push ${env.REGISTRY}/${env.IMAGE_NAME}"
                    }
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

