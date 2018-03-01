generate_sshkey(){
    if [ ! -z "$PAYLOADS_DIR" ] && [ ! -e $PAYLOADS_DIR/ssh ]; then
	mkdir -pv $PAYLOADS_DIR/ssh $PAYLOADS_DIR/ssh-key
	ssh-keygen -b 4096 -t rsa -P "" -C "Mad-Gantry RSA SSH Key" -f $PAYLOADS_DIR/ssh/rsa
	ln -s rsa.pub $PAYLOADS_DIR/ssh/authorized_keys
	mv -v $PAYLOADS_DIR/rsa $PAYLOADS_DIR/ssh-key/rsa
    fi
}

connect_via_ssh(){
    local site_name=$1
    [ ! -e $PAYLOADS_DIR/ssh-key/rsa ] && echo "$PAYLOADS_DIR/ssh-key/rsa does not exist" && return 1 
    [ -z "$site_name" ] && echo "[$site_name] is empty" && return 1

    local ssh_port=$(get_ssh_port $site_name)
    [ -z "$ssh_port" ] && echo "Cannot find ssh_port [$ssh_port]" && return 1 
    local ssh_host=localhost
    echo "Connecting to $site_name container [$ssh_host:$ssh_port] ..."
    ssh -Y -o "StrictHostKeyChecking=no" -i $PAYLOADS_DIR/ssh-key/rsa -p $ssh_port root@$ssh_host
    return $?
}

get_ssh_port(){
    local site_name=$1

    local i

    ## Level 0
    [ "$site_name" == "$LEVEL0_SITE" ] && echo $(($SSH_PORT_START + $LEVEL0_PORT)) && return 0

    ## Level 1
    for i in $(seq 0 $((${#LEVEL1_SITES[*]} - 1)))
    do
	[ "$site_name" == "${LEVEL1_SITES[$i]}" ] && echo $(($SSH_PORT_START + ${LEVEL1_PORTS[$i]})) && return 0
    done

    ## Level 2
    for i in $(seq 0 $((${#ALL_LEVEL2_SITES[*]} - 1)))
    do
	[ "$site_name" == "${ALL_LEVEL2_SITES[$i]}" ] && echo $(($SSH_PORT_START + ${ALL_LEVEL2_PORTS[$i]})) && return 0
    done

    return 1
}
