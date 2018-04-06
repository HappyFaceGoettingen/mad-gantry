## This function is fetching a target development repository (HappyFaceMobile modules)
prepare_madmask_devel_env(){
    pushd $PAYLOADS_DIR

    ## Making dirs (data, devel, android-tools)
    [ ! -e data ] && mkdir -v data
    [ ! -e android-tools ] && mkdir -v android-tools

    if [ ! -e devel ]; then
	git clone https://github.com/HappyFaceGoettingen/HappyFace-MadMask.git
	ln -s HappyFace-MadMask devel
    else
	pushd devel
	local git_branch=$(git branch | grep "^\*" | awk '{print $2}')
	git pull origin $git_branch
	popd
    fi
    popd
}

