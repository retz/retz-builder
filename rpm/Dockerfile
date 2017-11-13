FROM centos:7.3.1611

ENV container docker

RUN yum -y install make git
COPY jdk-8u151-linux-x64.tar.gz /build/jdk-8u151-linux-x64.tar.gz

RUN tar xzf /build/jdk-8u151-linux-x64.tar.gz -C /
RUN git clone git://github.com/retz/retz

ENV JAVA_HOME /jdk1.8.0_151
ENV PATH /jdk1.8.0_151/bin:$PATH

WORKDIR /retz
RUN ./gradlew jar

CMD ["/sbin/init"]
