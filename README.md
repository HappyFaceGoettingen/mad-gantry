# Start HappyFace & HappyFaceMobile services

## The environments in our tset systems
 * Scientific Linux 7.3 or CentOS 7.3
 * Docker Ver. 1.2
 * Docker-compose Ver. 2.0


## Build HF template services 
     $ ./mad-gantry -a build

## Start HF template services
     $ ./mad-gantry -a up


# The mad-gantry CLI
## CLI options
     ./mad-gantry [option]
     mad-gantry, which uses docker-compose, is designed to build and run the standard HappyFace/HappyFaceMobile Monitoring systems on containers. This powerful command can easily ship many monitoring frameworks to Cloud/Cluster/WLCG environments.
     
      -I:  Install basic packages in this host node
      -d:  Make development environments in payloads
      -E:  email addresses
     
      -n:  Use docker-compose no-cache option
      -y:  Set a template YML file [default: templates/hmf.integration-devel/docker-compose.yml]
      -t:  Select a template [el7.test/hf.core/hf.mobile/hmf.devel/hmf.integration-devel/jenkins/xdesktop]
      -a:  Actions [build/up/down/logs/reload/inspect]
      -u:  Update development environments, and reload all running containers
     
      -i:  Select a ship image [default: happyface/hmf.el7]
      -s:  Select a ship template [ADC/DE/DESY-HH/FR/GoeGrid/MPPMU]
      -c:  Connect a container via ssh
     
      -A:  Put all (top, countries, sites) containers onto a ship
      -T:  Put a top container onto a ship
      -C:  Put a country container onto a ship  [country_code or all]
      -S:  Put a site container onto a a ship [site_name or all]
      -L:  Put a local site container onto a ship [local_name or all]
     
      * Examples
      ** Build [hmf.integration-devel] template images and run them
      ./mad-gantry -a build; ./mad-gantry -a up
     
      ** Build xdesktop template images and run them
      ./mad-gantry -t xdesktop -a build; ./mad-gantry -t xdesktop -a up
     
      ** Make deferent levels templates and run their containers
      ./mad-gantry -T; ./mad-gantry -s ADC -a up
      ./mad-gantry -C DE; ./mad-gantry -s DE -a up
      ./mad-gantry -S GoeGrid; ./mad-gantry -s GoeGrid -a up
      ./mad-gantry -L GoeGrid_Custom; ./mad-gantry -s GoeGrid_Custom -a up
     
      ** Make all templates [from level0 to level3]
      ./mad-gantry -A
     
      ** Connect a site container via ssh
      ./mad-gantry -s GoeGrid -c
     



## Directory structure
    ├── configs         ---> Level0, 1, 2 site configurations
    ├── libs            ---> Custom libraries
    ├── mad-gantry      ---> Main program
    ├── mad-gantry.conf 
    ├── ticket.conf     ---> Site configuration
    ├── payloads        ---> Container local volumes of WLCG sites
    ├── ship            ---> Container definitions of WLCG sites
    └── templates       ---> Docker image templates
        ├── hf.core
        │   └── docker-compose.yml
        ├── hf.mobile
        │   └── docker-compose.yml
        ├── hmf.integration-devel (= Default template)
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
| HMF Integration el6 | OK | OK |
| HMF Integration el7 | OK | OK |
| Jenkins | X | OK |


## Jenkins service (testing the template for now)
### https://www.cloudbees.com/blog/get-started-jenkins-20-docker
     $ docker pull jenkins
     $ docker run --name jenkins -p 8080:8080 jenkins
     $ docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword

### In mad-gantry
     $ ./mad-gantry -a build -y templates/jenkins.template/docker-compose.yml
     $ ./mad-gantry -a up -y templates/jenkins.template/docker-compose.yml



## Some templates we've included
* https://github.com/deviantony/docker-elk


## Reference
* docker-compose: https://docs.docker.com/compose/
* https://devcenter.bitrise.io/docker/run-your-build-locally-in-docker/


## Automatic rebuild (hourly CRON job)
     # Add the following line into crontab, then mad-gantry checks, rebuilds and reload the running containers every hour
     1 */1 * * *  /home/cloud/mad-gantry/mad-gantry -U; /home/cloud/mad-gantry/mad-gantry -E "emails@example.com" -u hmf.devel &> /tmp/mad-gantry.cron.log

