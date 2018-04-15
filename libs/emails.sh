deploy_mailrc(){
    sudo yum -y install mailx msmtp ca-certificates sharutils

    echo "Writing mailrc and msmtprc configurations ..."

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

    echo -n "Gmail user name > "
    read GMAIL_USER
    echo -s -n "Gmail password > "
    read GMAIL_PASS

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

    echo "Turn 'allow less secure apps of gmail' on."
}


send_email(){
    local subject="$1"
    local message="$2"
    local emails="$3"

    echo "Sending [$subject] email to [" $emails "] ..."
    local e=
    for e in $emails
    do
        echo "$message" | $MAILER -A gmail -s "$subject" $e
        sleep 5
    done
}
