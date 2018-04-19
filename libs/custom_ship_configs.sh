apply_custom_ship_configs(){
    local config_json=$1
    [ ! -e $config_json ] && echo "[$config_json] does not exist" && return 1

    ## Changing firefox_profile location in config.json
    if ls $PAYLOADS_DIR/firefox/* &> /dev/null; then
	local firefox_profile=$(basename $(ls $PAYLOADS_DIR/firefox | head -n 1))
	echo "Applying [$firefox_profile] to [$config_json]"
	sed -e "s/\"firefox_profile\": .*$/\"firefox_profile\": \"\/firefox\/$firefox_profile\"/g" -i $config_json
    fi
    return 0
}
