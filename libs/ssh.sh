generate_sshkey(){
    if [ ! -z "$PAYLOADS_DIR" ] && [ ! -e $PAYLOADS_DIR/ssh ]; then
	mkdir -pv $PAYLOADS_DIR/ssh $PAYLOADS_DIR/ssh-key
	ssh-keygen -b 4096 -t rsa -P "" -C "Mad-Gantry RSA SSH Key" -f $PAYLOADS_DIR/ssh/rsa
	ln -s rsa.pub $PAYLOADS_DIR/ssh/authorized_keys
	mv -v $PAYLOADS_DIR/ssh/rsa $PAYLOADS_DIR/ssh-key/rsa
    fi
}

connect_via_ssh(){
    local site_name=$1
    [ ! -e $PAYLOADS_DIR/ssh-key/rsa ] && echo "$PAYLOADS_DIR/ssh-key/rsa does not exist" && return 1 
    [ -z "$site_name" ] && echo "site_name [$site_name] is empty" && return 1

    local ssh_port=$(get_ssh_port $site_name)
    [ -z "$ssh_port" ] && echo "Cannot find ssh_port [$ssh_port]" && return 1 
    local ssh_host=localhost
    echo "Connecting to $site_name container [$ssh_host:$ssh_port] ..."
    echo "ssh -Y -o StrictHostKeyChecking=no -o PasswordAuthentication=no -i $PAYLOADS_DIR/ssh-key/rsa -p $ssh_port root@$ssh_host"
    ssh -Y -o StrictHostKeyChecking=no -o PasswordAuthentication=no -i $PAYLOADS_DIR/ssh-key/rsa -p $ssh_port root@$ssh_host
    return $?
}

get_ssh_port(){
    local site_name=$1

    local i
    for i in $(seq 0 $((${#ALL_SITES[*]} - 1)))
    do
	[ "$site_name" == "${ALL_SITES[$i]}" ] && echo $(($SSH_PORT_START + ${ALL_PORTS[$i]})) && return 0
    done
    return 1
}
