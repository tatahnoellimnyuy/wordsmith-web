
pipeline {
    agent any
    stages {
        stage('Build artifact') {
            steps {
                echo 'Building the application artfact ...'
                // Example build command
                sh '''
                    rm -f wordsmith 
                    rm -f go.mod
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
        // stage('push docker image to dockerHub') {
        //     steps {
        //         echo 'Running push...'
        //         sh 'docker tag jenkinsimage toxicmoel/jenkinsimage:${BUILD_ID}'
        //         sh 'docker login -u="toxicmoel" -p="Jesuisroot123@"'
        //         sh 'docker push toxicmoel/jenkinsimage:${BUILD_ID} '
                
        //     }
        //  }
        // stage('Deploy') {
        //     steps {
        //         echo 'Deploying the application...'
                
        //         sh 'ssh -o StrictHostKeyChecking=no -i "../my-first.pem" ec2-user@ec2-35-182-61-252.ca-central-1.compute.amazonaws.com -t "docker ps -aq | xargs docker rm -f; docker run -p 80:80 -d toxicmoel/jenkinsimage:${BUILD_ID}"'
                
        //     }
        // }
    }
}
