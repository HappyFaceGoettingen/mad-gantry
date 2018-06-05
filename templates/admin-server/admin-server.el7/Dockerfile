FROM centos:7

## Generating basis
RUN yum --nogpgcheck -y install epel-release
RUN yum --nogpgcheck -y install git unzip wget rpm-build screen emacs tar initscripts cronie-anacron
RUN yum --nogpgcheck -y install https://download1.rpmfusion.org/free/el/rpmfusion-free-release-6.noarch.rpm


## Development and dependent packages
RUN yum -y install npm nodejs openssl openssl-libs openssl-devel


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


## Booting Admin Server
ADD build-admin-server.sh /src/build-admin-server.sh
CMD ["/src/build-admin-server.sh"]
