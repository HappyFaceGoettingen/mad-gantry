## This function is fetching a target development repository (HappyFaceMobile modules)
prepare_madmask_devel_env(){
    pushd $PAYLOADS_DIR
    [ ! -e data ] && mkdir -v data
    if [ ! -e devel ]; then
	git clone https://github.com/HappyFaceGoettingen/HappyFace-MadMask.git
	ln -s HappyFace-MadMask devel
    else
	pushd devel

	local cuser=$(ls -l | tail -n 1 | awk '{print $3}')
	[ "$user" != "$USER" ] && sudo chown -R $USER .
	git pull origin
	sudo chown -R $cuser .

	popd
    fi
    popd
}

