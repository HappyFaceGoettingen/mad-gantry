## This function is generating a template of a "top" level container into ship & payloads
put_level0_containers_onto_ship(){
    local site_dir=$PAYLOADS_DIR/sites/$LEVEL0_SITE

    output_docker_yml "$LEVEL0_SITE" "$LEVEL0_HOST" "$LEVEL0_PORT"
    copy_site_configs level0 $site_dir
    output_meta_meta_config "${LEVEL1_SITES[*]}" "${LEVEL1_HOSTS[*]}" "${LEVEL1_PORTS[*]}" $site_dir
}

