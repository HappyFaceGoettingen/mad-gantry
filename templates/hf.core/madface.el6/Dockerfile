FROM centos:6.7

## Generating basis
RUN yum --nogpgcheck -y install epel-release
RUN yum --nogpgcheck -y install git unzip wget rpm-build screen emacs tar initscripts cronie-anacron
RUN yum --nogpgcheck -y install https://download1.rpmfusion.org/free/el/rpmfusion-free-release-6.noarch.rpm


#--------------------------------------------------------
# Rebuilding MadFace instance
#--------------------------------------------------------
RUN yum --nogpgcheck -y install fftw-devel fftw2-devel libjpeg-turbo libjpeg-turbo-devel R-core R R-devel
RUN cd /var/lib && git clone https://github.com/MadFace/MadFace-rpm -b MadUpdate
RUN cd /var/lib/MadFace-rpm && git pull origin && ./rebuild.sh build madface

#--------------------------------------------------------
# Installing MadFace instance
#--------------------------------------------------------
RUN yum clean all
RUN yum -y install ftp://mirror.switch.ch/pool/4/mirror/scientificlinux/6.6/x86_64/updates/security/firefox-38.6.1-1.el6_7.x86_64.rpm 
RUN yum --nogpgcheck -y install /var/lib/MadFace-rpm/RPMS/x86_64/MadFace*.rpm

#--------------------------------------------------------
# Run MadFace
#--------------------------------------------------------
CMD dbus-uuidgen > /var/lib/dbus/machine-id && /usr/sbin/madface-default-start
