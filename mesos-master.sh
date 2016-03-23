#!/usr/bin/env bash


if [ -z "$ZOOKEEPER_ID" ]; then
    echo 1 | sudo dd of=/var/lib/zookeeper/myid
else
    echo $ZOOKEEPER_ID | sudo dd of=/var/lib/zookeeper/myid
fi

OPTS=""
if [ -z "$MESOS_MASTER_IP" ]; then
    echo "No MESOS_MASTER_IP set"
else
    echo "**** Setting Mesos Master IP to $MESOS_MASTER_IP"
    mkdir /etc/mesos-master
    echo $MESOS_MASTER_IP | tee /etc/mesos-master/ip
    cp /etc/mesos-master/ip /etc/mesos-master/hostname
     echo "**** Setting Mesos Master Quorum to $MESOS_QUORUM"

    echo "MESOS_QUORUM=$MESOS_QUORUM" >> /etc/default/mesos-master
    OPTS="--hostname=$MESOS_MASTER_IP --ip=$MESOS_MASTER_IP"
fi


echo Using OPTS: $OPTS

/usr/sbin/mesos-master $OPTS