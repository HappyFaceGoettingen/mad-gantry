FROM centos:7

## Generating basis
RUN yum --nogpgcheck -y install epel-release
RUN yum --nogpgcheck -y install git unzip wget rpm-build screen emacs tar initscripts cronie-anacron
RUN yum --nogpgcheck -y install https://download1.rpmfusion.org/free/el/rpmfusion-free-release-6.noarch.rpm


#--------------------------------------------------------
# Basic packages relating to SSH and Xwin 
#  (I do not know if we can remove some of those)
#--------------------------------------------------------
RUN yum update -y

RUN yum -y install openssh openssh-server openssh-clients
RUN sed -i '/pam_loginuid\.so/s/required/optional/' /etc/pam.d/sshd

RUN yum -y install xorg-x11-server-Xvfb xorg-x11-fonts-Type1 xorg-x11-fonts-misc dejavu-lgc-sans-fonts xorg-x11-fonts-75dpi xorg-x11-fonts-100dpi
RUN yum -y install xorg-x11-fonts-ISO8859-1-75dpi.noarch xorg-x11-fonts-ISO8859-1-100dpi.noarch
RUN yum -y install xterm xorg-x11-utils
RUN yum -y install gnome-panel gnome-terminal gnome-applets nautilus 
RUN yum -y install xinetd xorg-x11-xdm
RUN yum -y install vlgothic-fonts vlgothic-p-fonts ipa-gothic-fonts ipa-mincho-fonts ipa-pgothic-fonts ipa-pmincho-fonts
RUN yum -y install system-config-users
RUN yum -y install system-config-language system-config-date
RUN yum -y install centos-indexhtml



#--------------------------------------------------------
# Rebuilding HappyFace instance
#--------------------------------------------------------
RUN cd /var/lib && git clone https://github.com/HappyFaceGoettingen/HappyFace-Integration-Server -b MadUpdate
RUN cd /var/lib/HappyFace-Integration-Server && git pull origin && ./rebuild.sh happyface
RUN cd /var/lib/HappyFace-Integration-Server && git pull origin && ./rebuild.sh atlas
#RUN cd /var/lib/HappyFace-Integration-Server && git pull origin && ./rebuild.sh extra
#RUN cd /var/lib/HappyFace-Integration-Server && git pull origin && ./rebuild.sh webservice


#--------------------------------------------------------
# Installing HappyFace instance
#--------------------------------------------------------
RUN yum clean all
#RUN yum --nogpgcheck -y install /var/lib/HappyFace-Integration-Server/extras/python-migrate-*.rpm
RUN yum --nogpgcheck -y install /var/lib/HappyFace-Integration-Server/RPMS/x86_64/HappyFaceCore-*.rpm
#RUN yum --nogpgcheck -y install /var/lib/HappyFace-Integration-Server/RPMS/x86_64/HappyFace-ATLAS-*.rpm


#--------------------------------------------------------
# Rebuilding MadMask plugin
#--------------------------------------------------------
RUN yum --nogpgcheck -y install htop bwm-ng nmap
RUN yum --nogpgcheck -y install firefox fftw-devel fftw2-devel libjpeg-turbo libjpeg-turbo-devel R-core R R-devel npm nodejs tmpwatch bc xdotool ImageMagick jq sysstat
RUN yum --nogpgcheck -y install ant ant-apache-regexp ant-nodeps java-1.5.0-gcj java-1.7.0-openjdk java-1.7.0-openjdk-devel java-1.7.0-openjdk-headless java_cup libgcj regexp sinjdoc xerces-j2 xml-commons-apis xml-commons-resolver zip
RUN yum --nogpgcheck -y install yum install nss-softokn-freebl.i686 libstdc++.i686 zlib.i686

#RUN cd /var/lib && git clone https://github.com/HappyFaceGoettingen/HappyFace-MadMask.git -b master
#RUN cd /var/lib/HappyFace-MadMask/HappyFace-MadMask && git pull origin && ./rebuild.sh build all


#--------------------------------------------------------
# To avoid 'D-Bus Operation not permitted error'
#--------------------------------------------------------
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;


## MadMask builder
ADD build-madmask.sh /src/build-madmask.sh
CMD ["/src/build-madmask.sh"]
