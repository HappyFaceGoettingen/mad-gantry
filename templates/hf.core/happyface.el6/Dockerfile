FROM centos:6.7

## Generating basis
RUN yum --nogpgcheck -y install epel-release
RUN yum --nogpgcheck -y install git unzip wget rpm-build screen emacs tar initscripts cronie-anacron
RUN yum --nogpgcheck -y install https://download1.rpmfusion.org/free/el/rpmfusion-free-release-6.noarch.rpm


#--------------------------------------------------------
# Rebuilding HappyFace instance
#--------------------------------------------------------
RUN cd /var/lib && git clone https://github.com/HappyFaceGoettingen/HappyFace-Integration-Server -b MadUpdate
RUN cd /var/lib/HappyFace-Integration-Server && git pull origin && ./rebuild.sh happyface

#--------------------------------------------------------
# Installing HappyFace instance
#--------------------------------------------------------
RUN yum clean all
RUN yum --nogpgcheck -y install /var/lib/HappyFace-Integration-Server/extras/python-migrate-*.rpm
RUN yum --nogpgcheck -y install /var/lib/HappyFace-Integration-Server/RPMS/x86_64/*.rpm

#--------------------------------------------------------
# Run HappyFace
#--------------------------------------------------------
CMD ["-D", "FOREGROUND", "-e", "DEBUG"]
ENTRYPOINT ["/usr/sbin/httpd"]
