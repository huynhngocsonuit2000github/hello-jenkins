pipeline {
    agent any

    stages {
        stage('Clone Git Repository') {
            steps {
                script {
                    sh ''' 
                    # Start the SSH agent and add the private key
                    eval $(ssh-agent -s) 
                    ssh-add /var/jenkins_home/private_key
                    ssh-add -l
                    '''
                }
            }
        }
    }
}
