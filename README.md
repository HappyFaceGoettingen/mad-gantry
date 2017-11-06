# Start HappyFace & MadFace services
## Build HF & MF template services 
$ ./mad-gantry -a build

## Start HF & MF template services
$ ./mad-gantry -a up


# Start Jenkins service
## https://www.cloudbees.com/blog/get-started-jenkins-20-docker

$ docker pull jenkins
$ docker run --name jenkins -p 8080:8080 jenkins
$ docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword

## In mad-gantry
$ ./mad-gantry -a build -y templates/jenkins.template/docker-compose.yml
$ ./mad-gantry -a up -y templates/jenkins.template/docker-compose.yml


# The mad-gantry CLI
## CLI options
   $ ./mad-gantry
   ./mad-gantry [option]
  
   -n:  Use docker-compose no-cache option
   -y:  Set a template YML file [default: templates/hf.core.template/docker-compose.yml]
   -a:  Actions [build/up/down/logs]
   
   
   -s:  Generate ship
   
   -c:  Put country containers onto a ship  [all or country_code]
   -p:  Put site containers onto a ship [all or site]
   
   
    Report Bugs to Gen Kawamura <gen.kawamura@cern.ch>



# Directory structure
  ├── configs
  │   ├── commons   ---> Common configuratio for HF instance
  │   └── customs   ---> Custom configuratio for HF instance
  ├── mad-gantry
  ├── mad-gantry.conf
  ├── payloads      ---> Container Local volumes
  ├── README.md
  ├── ship          ---> Configurations of WLCG sites
  └── templates
      ├── hf.core.template
      │   └── docker-compose.yml
      ├── hf.mobile.templates
      │   └── docker-compose.yml
      └── jenkins.template
      	  └── docker-compose.yml

