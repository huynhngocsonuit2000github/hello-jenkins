pipeline {
    agent any

    stages {
        stage('Check data') {
            steps {
                script {
                    sh '''
		    echo "Data from repo" 
	 	    ls
                    '''
                }
            }
        }
    }
}
