## This function is generating templates of "site" level containers into ship & payloads
put_level2_containers_onto_ship(){
    local site=$1

    local i
    for i in $(seq 0 $((${#ALL_LEVEL2_SITES[*]} - 1)))
    do
	if [ "${ALL_LEVEL2_SITES[$i]}" == "$site" ] || [ "$site" == "all" ]; then
	    local site_dir=$PAYLOADS_DIR/sites/${ALL_LEVEL2_SITES[$i]}
	    output_docker_yml "${ALL_LEVEL2_SITES[$i]}" "${ALL_LEVEL2_HOSTS[$i]}" "${ALL_LEVEL2_PORTS[$i]}"
	    copy_site_configs level2 $site_dir
	    output_meta_meta_config "" "" "" $site_dir
	fi
    done
}


