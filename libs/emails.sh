deploy_mailrc(){
    echo "Installing mail packages ..."
    rpm -q mailx msmtp ca-certificates sharutils || sudo yum -y install mailx msmtp ca-certificates sharutils

    ## ask if we need
    echo -n "Configure Gmail account? [y/n]> "
    read proceed
    [ "$proceed" == "n" ] && return 0

    ## User and Password
    echo "Writing mailrc and msmtprc configurations ..."
    echo -n "Gmail user name > "
    read GMAIL_USER
    echo -n "Gmail password > "
    read -s GMAIL_PASS

    ## .mailrc
    echo "# gmail account
# set Allow less secure apps ON in gmail config
# $ mail -A gmail -s subject -a /path/file recipient@email.com < /path/body.txt
account gmail {
set from=\"no-reply@nodomain.com\"
set sendmail=\"/usr/bin/msmtp\"
set message-sendmail-extra-arguments=\"-a gmail\"
}
" > $HOME/.mailrc

    ## .msmtprc
echo "defaults
logfile /tmp/msmtp.$(whoami).log

# gmail account
account gmail
host smtp.gmail.com
port 587
user $GMAIL_USER
password $GMAIL_PASS
auto_from off
from no-reply@nodomain.com

auth on
tls on
tls_starttls on
tls_trust_file /etc/pki/tls/certs/ca-bundle.crt

# set default account to use (from above)
account default : gmail
" > $HOME/.msmtprc

    chmod 600 $HOME/.msmtprc

    echo "Turn 'allow less secure apps of gmail' on.
  * https://myaccount.google.com/lesssecureapps?pli=1"

}


send_email(){
    local subject="$1"
    local message="$2"
    local message_file="$3"
    local emails="$4"

    [ ! -z "$message_file" ] && message_file="-a $message_file"

    echo "Sending [$subject] email to [" $emails "] ..."
    local e=
    for e in $emails
    do
        echo "$message" | $MAILER -A gmail -s "$subject" $message_file $e
        sleep 5
    done
}
