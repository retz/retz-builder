FROM ubuntu:16.04

ENV container docker

RUN apt-get update
RUN apt-get -y install make git systemd
COPY jdk-8u141-linux-x64.tar.gz /build/jdk-8u141-linux-x64.tar.gz

# cf. Running systemd within a Docker Container – Red Hat Developer Blog
#   http://developers.redhat.com/blog/2014/05/05/running-systemd-within-docker-container/
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN tar xzf /build/jdk-8u141-linux-x64.tar.gz -C /
RUN git clone git://github.com/retz/retz

ENV JAVA_HOME /jdk1.8.0_141
ENV PATH /jdk1.8.0_141/bin:$PATH

WORKDIR /retz
RUN ./gradlew jar
