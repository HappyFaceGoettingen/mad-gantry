SENDEMAIL(){
    local subject="$1"
    local message="$2"
    local message_file="$3"
    local emails="$4"

    echo "Sending [$subject] email to [" $emails "] ..."
    local e=
    for e in $emails
    do
        echo "$message" | $MAILER -a $message_file -s "$subject" $e
        sleep 5
    done
}
