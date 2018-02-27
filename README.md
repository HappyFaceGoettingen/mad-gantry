# Start HappyFace & HappyFaceMobile services
## Build HF template services 
$ ./mad-gantry -a build

## Start HF template services
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
    ./mad-gantry [option]
    
    mad-gantry, which uses docker-compose, is designed to build the standard HappyFace/HappyFaceMobile/Kibana Monitoring systems on containers. This powerful command can easily ship many complex monitoring frameworks to Cloud/Cluster/WLCG environments.
    
    
    -n:  Use docker-compose no-cache option
    -y:  Set a template YML file [default: templates/hf.core/docker-compose.yml]
    -t:  Select a template [hf.core/hf.mobile/hmf.integration-devel/jenkins/xdesktop/]
    -a:  Actions [build/up/down/logs]
    
    
    -s:  Select a ship template [adcos/de/fr/goegrid/]
    
    -A:  Put all (top, countries, sites) containers onto a ship
    -T:  Put a top container onto a ship
    -C:  Put a country container onto a ship  [country_code or all]
    -S:  Put a site container onto a a ship [site_name or all]
    
    
     * Examples
    
     ** Build hf.core images and run them
     ./mad-gantry -a build; ./mad-gantry -a up
    
     ** Build xdesktop images and run them
     ./mad-gantry -t xdesktop -a build; ./mad-gantry -t xdesktop -a up
    
     ** Make a Top level template and run its container
     ./mad-gantry -T; ./mad-gantry -s adcos -a up
    
     ** Make a Country level template and run its container
     ./mad-gantry -C de; ./mad-gantry -s de -a up
    
     ** Make a Site level template and run its container
     ./mad-gantry -S goegrid; ./mad-gantry -s goegrid -a up
    
    
     Report Bugs to Gen Kawamura <gen.kawamura@cern.ch>




## Directory structure
    ├── mad-gantry
    ├── mad-gantry.conf
    ├── ticket.conf   ---> Site configuration
    ├── payloads      ---> Container local volumes of WLCG sites
    ├── ship          ---> Container definitions of WLCG sites
    └── templates
        ├── hf.core
        │   └── docker-compose.yml
        ├── hf.mobile
        │   └── docker-compose.yml
        ├── hf.integration
        │   └── docker-compose.yml
        └── jenkins
            └── docker-compose.yml


## Build & Run status
| Template | Img build | Web/ApkBuilder Run |
----|----|----
| HF Core el6 | OK | OK |
| HF Core el7 | OK | NO |
| MF Core el6 | OK | OK |
| MF Core el7 | OK | OK |
| HF Mobile el6 | OK | -- |
| HF Mobile el7 | OK | -- |
| MF Mobile el6 | OK | -- |
| MF Mobile el7 | OK | -- |
| HMF Mobile el6 | OK | -- |
| Jenkins | X | OK |

