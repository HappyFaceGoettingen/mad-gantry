## Start Jenkins service
# https://www.cloudbees.com/blog/get-started-jenkins-20-docker

$ docker pull jenkins
$ docker run --name jenkins -p 8080:8080 jenkins
$ docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword

## Start HappyFace & MadFace services
# build core services and start template services
$ ./mad-gantry 
