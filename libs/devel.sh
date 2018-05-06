## This function is fetching a target development repository (HappyFaceMobile modules)
prepare_madmask_devel_env(){
    local ret=1
    pushd $PAYLOADS_DIR

    ## Making dirs (data, devel, android-tools)
    [ ! -e data ] && mkdir -v data
    [ ! -e android-tools ] && mkdir -v android-tools
    [ ! -e firefox ] && mkdir -v firefox

    if [ ! -e devel ]; then
	git clone https://github.com/HappyFaceGoettingen/HappyFace-MadMask.git
	ln -s HappyFace-MadMask devel
    else
	pushd devel
	local git_branch=$(git branch | grep "^\*" | awk '{print $2}')
	git pull origin $git_branch | grep "^Already up-to-date"
	[ $? -ne 0 ] && ret=0
	popd
    fi
    popd
    return $ret
}


get_devel_branch_name(){
    pushd $PAYLOADS_DIR/devel &> /dev/null
    echo $(git branch | grep "^\*" | awk '{print $2}')
    popd &> /dev/null
}

git_last_log(){
    pushd $PAYLOADS_DIR/devel &> /dev/null
    echo $(git log -1)
    popd &> /dev/null
}

devel_version_and_id(){
    pushd $PAYLOADS_DIR/devel &> /dev/null
    echo $(cat Version.txt) - Git $(git log -1 | grep "^commit")
    popd &> /dev/null
}
