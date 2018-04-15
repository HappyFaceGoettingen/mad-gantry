install_basic_packages(){
    echo "Installing basic packages"

    ## Basic pacakges
    sudo yum -y --nogpgcheck install emacs screen htop git nmap mail iotop
    
    ## Docker
    sudo yum -y --nogpgcheck install docker docker-compose
    sudo service docker start
    sudo chkconfig docker on
    sudo usermod -aG dockerroot $USER
    
    if [ ! -e /etc/profile.d/docker.sh ]; then
	echo "alias docker-socket-on=\"sudo chmod 666 /var/run/docker.sock\"" > /tmp/docker.sh
	sudo cp -v /tmp/docker.sh /etc/profile.d/
	sudo chmod 666 /var/run/docker.sock
    fi
}
