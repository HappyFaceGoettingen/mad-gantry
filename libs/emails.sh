SENDEMAIL(){
    local subject="$1"
    local message_file="$2"
    local emails="$3"

    echo "Sending [$subject] email to [" $emails "] ..."
    local e=
    for e in $emails
    do
        cat "$message_file" | $MAILER -s "$subject" $e
        sleep 0.5
    done
}
