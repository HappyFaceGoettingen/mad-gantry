send_osx_build_command(){
    local osx_host="$1"
    local command="$2"
    
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


get_osx_built_application(){
    local osx_host="$1"
    local remote_dir="$2"
    local local_dir="$3"

    
}
