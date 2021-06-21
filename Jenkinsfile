pipeline {
    agent any

    tools {
        maven 'localMaven'
    }

    parameters {
        string(name: 'tomcat_prod', defaultValue: '54.237.65.218', description: 'Prod instance')
        string(name: 'tomcat_stage', defaultValue: '54.237.63.91', description: 'stage instance')
    }

    triggers {
        pollSCM('* * * * *')
    }

    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }

            post {
                success {
                    echo 'Now archiving...'
                    archiveArtifacts artifacts: '**/*.war'
                }
            }
        }

        stage('Deployments') {
            parallel {
                stage('Deploy to Staging'){
                    steps {
                        sh "scp -o StrictHostKeyChecking=no -i $HOME/ansible.pem $HOME/workspace/full-pipeline/webapp/target/*.war ubuntu@${params.tomcat_prod}:/var/lib/tomcat8/webapps"
                    }
                }

                stage('Deploy to Prod'){
                    steps {
                        sh "scp -o StrictHostKeyChecking=no -i $HOME/ansible.pem $HOME/workspace/full-pipeline/webapp/target/*.war ubuntu@${params.tomcat_stage}:/var/lib/tomcat8/webapps"
                    }
                }
            }
        }
    }
}
