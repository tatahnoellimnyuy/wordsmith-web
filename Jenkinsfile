
pipeline {
    agent any
    stages {
         stage('scan files') {
            steps {
                withCredentials([string(credentialsId: 'sonarqube-id', variable: 'login')]) {
                echo 'scanning  ...'
                // Example build command
                sh '''
                   /opt/sonar-scanner/bin/sonar-scanner \
                      -Dsonar.projectKey=go-analysis \
                      -Dsonar.sources=. \
                      -Dsonar.host.url=http://34.201.44.26:9000 \
                      -Dsonar.login=$login
                '''
            }
            }
        }
        stage('Build artifact') {
            steps {
                echo 'Building the application artfact ...'
                // Example build command
                sh '''
                    
                    go mod init wordsmith
                    go mod tidy
                    go build
                '''
            }
        }
        stage('push to nexus') {
            steps {
                echo 'pushing to nexus...'    
            }
         }
        stage('build docker image') {
            steps {
                echo 'creating docker image...'
                sh 'docker build -t wordsmithweb . '
            }
         }
        stage('push docker image to dockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                echo 'Running push...'
                sh 'docker tag wordsmithweb toxicmoel/wordsmithweb:${BUILD_ID}'
                sh 'docker login -u="$USERNAME" -p="$PASSWORD"'
                sh 'docker push toxicmoel/wordsmithweb:${BUILD_ID} '
                
            }
            }
         }
        stage('Deploy') {
            steps {
                echo 'Deploying the application...'
                
                sh 'ssh -o StrictHostKeyChecking=no -i "../../my-first.pem" ec2-user@ec2-35-182-61-252.ca-central-1.compute.amazonaws.com -t "docker ps -aq | xargs docker rm -f; docker run -p 80:80 -d toxicmoel/wordsmithweb:${BUILD_ID}"'
                
            }
        }
    }
  post {
        always {
            echo "Cleaning up workspace and temporary files..."
            
            // Delete the workspace to remove files from the agent
            cleanWs()

        }

        success {
            echo "Build completed successfully. Performing success-specific actions..."
        }

        failure {
            echo "Build failed. Performing failure-specific cleanup actions..."
        }
    }  
}
