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

        stage('Deploy to Staging'){
            steps {
                build job: 'deploy-to-staging'
            }
        }

        stage('Deploy to production') {
            steps {
                timeout(time: 5, unit: 'DAYS') {
                    input message: 'Approve PRODUCTION deployment'
                }

                build job: 'deploy-to-prod'
            }

            post{
                success {
                    echo 'Code deployed to production'
                }

                failure {
                    echo 'Deployment failed'
                }
            }
        }
    }
}
