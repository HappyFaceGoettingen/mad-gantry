apply_custom_ship_configs(){
    local site=$1
    local config_json=$2
    [ ! -e $config_json ] && echo "[$config_json] does not exist" && return 1

    echo "Applying version and ports"

    ## Applying version name
    sed -e "s/\(\"version\":\) .*$/\1 \"$(devel_version_and_id)\",/g" -i $config_json

    ## Applying ports
    local i
    for i in $(seq 0 $((${#ALL_SITES[*]} - 1)))
    do
	if [ "$site" == "${ALL_SITES[$i]}" ]; then
	    local mobile_port=$(echo $(($MOBILE_PORT_START + ${ALL_PORTS[$i]})))
	    local web_port=$(echo $(($WEB_PORT_START + ${ALL_PORTS[$i]})))
	    sed -e "s/\(\"ionic_port\":\) .*$/\1 \"$DEFAULT_MOBILE_PORT\",/g" -i $config_json
	    sed -e "s/\(\"mobile_port\":\) .*$/\1 \"$mobile_port\",/g" -i $config_json
	    sed -e "s/\(\"web_port\":\) .*$/\1 \"$web_port\",/g" -i $config_json
	fi
    done
    

    ## Changing firefox_profile location in config.json
    if [ ! -z "$(ls $PAYLOADS_DIR/firefox)" ]; then
	local firefox_profile=$(basename $(ls $PAYLOADS_DIR/firefox | head -n 1))
	echo "Applying [$firefox_profile] to [$config_json]"
	sed -e "s/\"firefox_profile\": .*$/\"firefox_profile\": \"\/firefox\/$firefox_profile\"/g" -i $config_json
    fi
    return 0
}


## Selecting sub-functions, according to "ship_name"
apply_special_custom_ship_configs(){
    local site=$1
    local site_dir=$2
    local ship_name=$3

    case $ship_name in
	docker-elk)
	    apply_elk_ship_configs $site $site_dir
	    ;;
	*)
	    ;;
    esac
}
