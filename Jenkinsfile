pipeline {
    agent {
        docker {
            image 'node:12-alpine'
            args '-p 3000:3000 -p 5000:5000'
        }
    }
    environment { 
        CI = 'true'
    }
    stages {
        stage('Build') {
            steps {
                sh 'npm install'
            }
        }
        stage('Test') {
            steps {
                sh 'chmod +x ./jenkins/scripts/test.sh'            
                sh './jenkins/scripts/test.sh'
            }
        }
        stage('Deliver for development') {
            when {
                branch 'development'
            }
            steps {
                sh 'chmod +x ./jenkins/scripts'
                sh './jenkins/scripts/deliver.sh'
                input message: 'Finished using the web site? (Click "Proceed" to continue)'
                sh './jenkins/scripts/kill.sh'
            }
        }
        stage('Deploy for production') {
            when {
                branch 'production'
            }
            steps {
                sh 'chmod +x ./jenkins/scripts/deployment.sh'
                sh './jenkins/scripts/deployment.sh'
                input message: 'Finished with your production version? (Click "Proceed" to continue)'
                sh 'chmod +x ./jenkins/scripts/kill.sh'
                sh './jenkins/scripts/kill.sh'                
            }
        }        
    }
}