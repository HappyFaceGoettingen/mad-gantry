install_basic_packages(){
    echo "Installing basic packages"

    ## Basic pacakges
    local packages="emacs screen htop git nmap mailx iotop"
    rpm -q $packages || sudo yum -y --nogpgcheck install $packages
    
    ## Docker
    rpm -q docker-compose || sudo yum -y --nogpgcheck install docker docker-compose
    sudo service docker start
    sudo chkconfig docker on
    sudo usermod -aG dockerroot $USER

    ## Docker storage configuraiton
    [ ! -z "$DOCKER_STORAGE_SIZE" ] && sudo sed -e "s/^DOCKER_STORAGE_OPTIONS=.*$/DOCKER_STORAGE_OPTIONS=\"--storage-opt dm.basesize=$DOCKER_STORAGE_SIZE\"/g" -i /etc/sysconfig/docker-storage

    ## A useful alias to enable the docker socket    
    if [ ! -e /etc/profile.d/docker.sh ]; then
	echo "alias docker-socket-on=\"sudo chmod 666 /var/run/docker.sock\"" > /tmp/docker.sh
	sudo cp -v /tmp/docker.sh /etc/profile.d/
	sudo chmod 666 /var/run/docker.sock
    fi
}
