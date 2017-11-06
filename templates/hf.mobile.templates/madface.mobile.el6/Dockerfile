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
RUN cd /var/lib/MadFace-rpm && git pull origin && ./rebuild.sh build madface && ./rebuild.sh build android

#--------------------------------------------------------
# Installing MadFace instance
#--------------------------------------------------------
RUN yum clean all
RUN yum --nogpgcheck -y install /var/lib/MadFace-rpm/RPMS/x86_64/MadFace*.rpm

#--------------------------------------------------------
# Rebuild smartphone App
#--------------------------------------------------------

