make_kibana_payloads(){
    [ ! -e $PAYLOADS_DIR/ELK ] && ln -vs ../templates/docker-elk $PAYLOADS_DIR/ELK
}


apply_elk_ship_configs(){
    local site=$1
    local site_dir=$2
    local lsite=$(echo "$site" | sed 's/\(.*\)/\L\1/')

    local files=$(find $site_dir -type f)
    for f in $files
    do
	echo "Changing properties in [$f] ..."
	sed -e "s/__SITE__/$lsite/g" -i $f
    done
}
