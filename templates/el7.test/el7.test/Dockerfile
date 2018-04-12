# This shows systemd services (nginx and named) running in a centos7 container.
# There have been lots of problems and workarounds for this, see:
# https://hub.docker.com/_/centos/
# https://github.com/docker/docker/issues/7459

#FROM centos:centos7
FROM centos:7

RUN yum install -y epel-release # for nginx
RUN yum install -y initscripts  # for old "service"

ENV container=docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

# named (dns server) service
RUN yum install -y httpd
RUN systemctl enable httpd.service

# Unrelated to systemd, but Apacehe httpd install fails at least if docker uses
# (default) aufs.
#   Error unpacking rpm package httpd-2.4.6-40.el7.centos.x86_64
#   error: unpacking of archive failed on file /usr/sbin/suexec: cpio: cap_set_file
#RUN yum install -y httpd

# webserver service
#RUN yum install -y nginx
#RUN systemctl enable nginx.service

# Without this, init won't start the enabled services and exec'ing and starting
# them reports "Failed to get D-Bus connection: Operation not permitted".
#VOLUME /run /tmp

#
ADD startup.sh /src/startup.sh

# Don't know if it's possible to run services without starting this
CMD /src/startup.sh

