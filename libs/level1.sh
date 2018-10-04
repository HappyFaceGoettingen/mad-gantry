## This function is generating templates of "contry" level containers into ship & payloads
put_level1_containers_onto_ship(){
    local site=$1
    local i
    for i in $(seq 0 $((${#LEVEL1_SITES[*]} - 1)))
    do
	if [ "${LEVEL1_SITES[$i]}" == "$site" ]; then
	    local site_dir=$PAYLOADS_DIR/sites/$site
	    output_docker_yml "${LEVEL1_SITES[$i]}" "${LEVEL1_HOSTS[$i]}" "${LEVEL1_PORTS[$i]}" "${LEVEL1_SHIPS[$i]}"
	    local sites=$(eval echo "\${LEVEL2_${site}_SITES[*]}")
	    local hosts=$(eval echo "\${LEVEL2_${site}_HOSTS[*]}")
	    local ports=$(eval echo "\${LEVEL2_${site}_PORTS[*]}")
	    copy_site_configs level1 $site_dir "${LEVEL1_SHIPS[$i]}"
	    output_meta_meta_config "$sites" "$hosts" "$ports" $site_dir
	fi
    done
}

