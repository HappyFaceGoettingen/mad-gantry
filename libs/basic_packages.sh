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

    ## A useful alias to enable the docker socket    
    if [ ! -e /etc/profile.d/docker.sh ]; then
	echo "alias docker-socket-on=\"sudo chmod 666 /var/run/docker.sock\"" > /tmp/docker.sh
	sudo cp -v /tmp/docker.sh /etc/profile.d/
	sudo chmod 666 /var/run/docker.sock
    fi
}


make_swap(){
    echo -n "Configure Swap? [y/n]> "
    read proceed
    [ "$proceed" != "y" ] && return 0

    [ ! -e /root/swap ] && sudo mkdir -vp /root/swap
    swap_file=/root/swap/swapfile
    echo -n "Input size of swap space [GB] > "
    read swap_size
    
    echo "swap size = ${swap_size} GB"
    sudo dd if=/dev/zero of=$swap_file bs=100M count=$(($swap_size * 10))
    
    echo "adding swap space [$swap_file]"
    sudo chmod 600 $swap_file
    sudo mkswap $swap_file
    sudo swapon $swap_file
    
    if [ -z "$(grep $swap_file /etc/fstab)" ]; then
	echo "$swap_file               swap                    swap    defaults        0 0"
    fi
}
