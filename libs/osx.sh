send_ios_apk_build_request(){
    local osx_host=${OSX[0]}
    local osx_port=${OSX[1]}
    local build_id=""

    local ios_build_command="build-apk4ios.sh -i $build_id -b"
    local ios_apk_file=""

    local build_log="$PAYLOADS_DIR/data/ADC/logs/madmask.ios-build.log"
    local local_ios_apk_file="$PAYLOADS_DIR/data/ADC/application/ios/HappyFace2"

    ## Remove old one
    [ -e $local_ios_apk_file ] && rm -vf $local_ios_apk_file

    ## Build start
    [ ! -e $PAYLOADS_DIR/ssh-key/rsa ] && echo "$PAYLOADS_DIR/ssh-key/rsa does not exist" && return 1
    local request="ssh -Y -o StrictHostKeyChecking=no -o PasswordAuthentication=no -i $PAYLOADS_DIR/ssh-key/rsa -p $osx_port $osx_host '$ios_build_command'"
    echo "$request"
    eval $request 2>&1 | tee $local_ios_build_log

    ## Copying new iPhoen APK
    scp -P $osx_port $osx_host $ios_apk_file $local_ios_apk_file 2>&1 | tee -a $local_ios_build_log
    return $?
}
