FROM ubuntu:14.04

#RUN DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]'); CODENAME=$(lsb_release -cs); echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME} main" | sudo tee /etc/apt/sources.list.d/mesosphere.list
#RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF

RUN apt-get -y update \
    && apt-get install -y tar wget git \
    && apt-get install -y openjdk-7-jdk \
    && apt-get install -y autoconf libtool \
    && apt-get -y install build-essential python-dev python-boto libcurl4-nss-dev libsasl2-dev libsasl2-modules maven libapr1-dev libsvn-dev \
    && apt-get -y install curl python-setuptools python-pip python-dev python-protobuf \
    && mkdir /opt

ADD http://www.apache.org/dist/mesos/0.27.1/mesos-0.27.1.tar.gz /opt/mesos-0.27.1.tar.gz

RUN cd /opt \
    && tar -xzf /opt/mesos-0.27.1.tar.gz \
    && ln -sf mesos-0.27.1 mesos \
    && cd mesos \
    && ./configure \
    && make \
    && make install

WORKDIR /opt/mesos
