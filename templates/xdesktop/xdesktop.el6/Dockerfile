FROM centos:6.7

## Generating basis
RUN yum --nogpgcheck -y install epel-release
RUN yum --nogpgcheck -y install git unzip wget rpm-build screen emacs tar initscripts cronie-anacron
RUN yum --nogpgcheck -y install https://download1.rpmfusion.org/free/el/rpmfusion-free-release-6.noarch.rpm


#--------------------------------------------------------
# Rebuilding MadFace instance
#--------------------------------------------------------
RUN yum update -y
RUN yum -y install openssh openssh-server openssh-clients
RUN service sshd start; service sshd stop
RUN sed -i '/pam_loginuid\.so/s/required/optional/' /etc/pam.d/sshd
RUN yum -y install xorg-x11-server-Xvfb xorg-x11-fonts-Type1 xorg-x11-fonts-misc dejavu-lgc-sans-fonts xorg-x11-fonts-75dpi xorg-x11-fonts-100dpi
RUN yum -y install xorg-x11-fonts-ISO8859-1-75dpi.noarch xorg-x11-fonts-ISO8859-1-100dpi.noarch
RUN yum -y install xterm xorg-x11-utils
RUN yum -y install gnome-panel gnome-terminal gnome-applets nautilus 
RUN yum -y install firefox libreoffice thunderbird
RUN yum -y install xinetd xorg-x11-xdm
RUN yum -y install vlgothic-fonts vlgothic-p-fonts ipa-gothic-fonts ipa-mincho-fonts ipa-pgothic-fonts ipa-pmincho-fonts
RUN yum -y install system-config-users
RUN yum -y install nautilus-open-terminal
RUN yum -y install system-config-language system-config-date
RUN yum -y install system-gnome-theme system-icon-theme 
RUN yum -y install centos-indexhtml
ADD rpms /src/rpms
RUN yum -y install /src/rpms/*.rpm
RUN cd /src ; wget https://bintray.com/artifact/download/tigervnc/stable/tigervnc-Linux-x86_64-1.4.2.tar.gz
RUN cd / ; tar --no-same-owner -xf src/tigervnc-Linux-x86_64-1.4.2.tar.gz
RUN echo "vnc1 5901/tcp" >> /etc/services
ADD vnc /etc/xinetd.d/vnc
RUN sed -i 's$:0 local /usr/bin/X :0$:0 local /usr/bin/Xvnc :0 -SecurityTypes None -desktop CentOS6 DisconnectClients=0$' /etc/X11/xdm/Xservers  
RUN sed -i "s/DisplayManager.requestPort:\t0/DisplayManager.requestPort:   177/" /etc/X11/xdm/xdm-config
RUN echo '*' >> /etc/X11/xdm/Xaccess
ADD startup.sh /src/startup.sh
ADD scim /etc/skel/.scim
#EXPOSE 22
CMD ["/src/startup.sh"]
