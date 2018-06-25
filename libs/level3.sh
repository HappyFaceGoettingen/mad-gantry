## This function is generating templates of "site" level containers into ship & payloads
put_level3_containers_onto_ship(){
    local site=$1
    local default_ship_image=$SHIP_IMAGE

    local i
    for i in $(seq 0 $((${#ALL_LEVEL3_SITES[*]} - 1)))
    do
	SHIP_IMAGE=$default_ship_image
	if [ "${ALL_LEVEL3_SITES[$i]}" == "$site" ]; then
	    [ ! -z "${ALL_LEVEL3_IMAGES[$i]}" ] && SHIP_IMAGE="${ALL_LEVEL3_IMAGES[$i]}"
	    local site_dir=$PAYLOADS_DIR/sites/${ALL_LEVEL3_SITES[$i]}
	    output_docker_yml "${ALL_LEVEL3_SITES[$i]}" "${ALL_LEVEL3_HOSTS[$i]}" "${ALL_LEVEL3_PORTS[$i]}"
	    copy_site_configs level3 $site_dir
	    output_meta_meta_config "" "" "" $site_dir
	fi
    done
}


