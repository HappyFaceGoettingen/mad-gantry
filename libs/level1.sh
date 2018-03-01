## This function is generating templates of "contry" level containers into ship & payloads
put_level1_containers_onto_ship(){
    local country=$1
    local i
    for i in $(seq 0 $((${#LEVEL1_SITES[*]} - 1)))
    do
	if [ "${LEVEL1_SITES[$i]}" == "$country" ] || [ "$country" == "all" ]; then
	    local country_code=${LEVEL1_SITES[$i]}
	    output_docker_yml "${LEVEL1_SITES[$i]}" "${LEVEL1_HOSTS[$i]}" "${LEVEL1_PORTS[$i]}"

	    local sites=$(eval echo "\${LEVEL2_${country_code}_SITES[*]}")
	    local hosts=$(eval echo "\${LEVEL2_${country_code}_HOSTS[*]}")
	    local ports=$(eval echo "\${LEVEL2_${country_code}_PORTS[*]}")
	    local site_dir=$PAYLOADS_DIR/sites/$country_code
	    copy_site_configs level1 $site_dir
	    output_meta_meta_config "$sites" "$hosts" "$ports" $site_dir
	fi
    done
}

