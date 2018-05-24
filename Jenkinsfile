pipeline {
    agent any
    stages {
        stage('Checkout'){
            steps {
                echo 'Checked out'
            }
        }
        stage('CollectArtifacts'){
            steps{
                echo 'Collecting Artifacts'
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }

}
