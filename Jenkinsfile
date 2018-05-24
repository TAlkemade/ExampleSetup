pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                sh 'echo Checked out'
            }
        }
        stage('CollectArtifacts') {
            steps{
                sh 'echo Collecting Artifacts'
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }

}
