apply_custom_ship_configs(){
    local config_json=$1
    [ ! -e $config_json ] && echo "[$config_json] does not exist" && return 1

    echo "Applying version and ports"

    ## Applying version name
    sed -e "s/\(\"version\":\) .*$/\1 \"$(devel_version_and_id)\",/g" -i $config_json

    ## Applying mobile_port

    ## Applying web_port

    ## Changing firefox_profile location in config.json
    if [ ! -z "$(ls $PAYLOADS_DIR/firefox)" ]; then
	local firefox_profile=$(basename $(ls $PAYLOADS_DIR/firefox | head -n 1))
	echo "Applying [$firefox_profile] to [$config_json]"
	sed -e "s/\"firefox_profile\": .*$/\"firefox_profile\": \"\/firefox\/$firefox_profile\",/g" -i $config_json
    fi
    return 0
}
