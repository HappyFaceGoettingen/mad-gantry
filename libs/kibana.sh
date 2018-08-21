make_kibana_payloads(){
    [ ! -e $PAYLOADS_DIR/ELK ] && ln -vs ../templates/docker-elk $PAYLOADS_DIR/ELK
}
