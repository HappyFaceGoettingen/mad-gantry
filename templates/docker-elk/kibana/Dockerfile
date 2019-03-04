# https://github.com/elastic/kibana-docker
#FROM docker.elastic.co/kibana/kibana:5.6.3
FROM docker.elastic.co/kibana/kibana:6.3.2

# Add your kibana plugins setup here
# Example: RUN kibana-plugin install <name|url>


# SSH configuration
USER root
RUN yum -y install openssh openssh-server openssh-clients
RUN sed -i '/pam_loginuid\.so/s/required/optional/' /etc/pam.d/sshd

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


## Adding kbn_network plugin
RUN yum -y install epel-release; yum -y install git npm
RUN cd /usr/share/kibana/plugins; git clone https://github.com/dlumbrer/kbn_network.git network_vis -b 6.4-dev; cd network_vis; rm -rf images; npm install


## Overwriting the kibana-docker script
ADD kibana-docker /usr/local/bin/kibana-docker



