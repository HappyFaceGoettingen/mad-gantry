## This function is fetching a target development repository (HappyFaceMobile modules)
prepare_madmask_devel_env(){
    pushd $PAYLOADS_DIR
    [ ! -e data ] && mkdir -v data
    if [ ! -e devel ]; then
	git clone https://github.com/HappyFaceGoettingen/HappyFace-MadMask.git
	ln -s HappyFace-MadMask devel
    fi
    popd
}

