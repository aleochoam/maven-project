pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh '/maven/apache-maven-3.8.1/bin/mvn clean package'
            }

            post {
                success {
                    echo 'Now archiving...'
                    archiveArtifacts artifacts: '**/*.war'
                }
            }
        }
    }
}
