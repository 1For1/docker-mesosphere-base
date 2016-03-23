FROM oneforone/backend-base:latest

MAINTAINER 1for.one <ops@1for.one>

RUN DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]'); CODENAME=$(lsb_release -cs); echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME} main" | sudo tee /etc/apt/sources.list.d/mesosphere.list
RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF

RUN apt-get -y update \
    && apt-get install -y tar wget git \
    && apt-get install -y openjdk-7-jdk \
    && apt-get install -y autoconf libtool \
    && apt-get -y install build-essential python-dev python-boto libcurl4-nss-dev libsasl2-dev libsasl2-modules maven libapr1-dev libsvn-dev \
    && apt-get -y install curl python-setuptools python-pip python-dev python-protobuf \
    && apt-get -y install mesos

ADD mesos-master.sh /opt/mesos
ADD mesos-slave.sh /opt/mesos

# Install mesos.
RUN sudo apt-get -y install mesos \
    && chmod a+x /opt/mesos/mesos-master.sh \
    && chmod a+x /opt/mesos/mesos-slave.sh \
    && sudo mkdir -p /etc/mesos-master \
    && echo in_memory | sudo dd of=/etc/mesos-master/registry


#ADD http://www.apache.org/dist/mesos/0.27.1/mesos-0.27.1.tar.gz /opt/mesos-0.27.1.tar.gz

#RUN cd /opt \
#    && tar -xzf /opt/mesos-0.27.1.tar.gz \
#   && ln -sf mesos-0.27.1 mesos \
#    && cd mesos \
#    && ./configure --disable-bundled-pip --prefix='/usr' \
#    && make \
#    && make install

WORKDIR /opt/mesos
