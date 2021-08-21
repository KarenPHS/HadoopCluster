FROM ubuntu:20.04
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
MAINTAINER Hsuan hsuan8169@gmail.com

USER root

RUN apt-get update

# Set Timezone
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tcl && echo "Asia/Taipei" > /etc/timezone

# First, set timezone, and then install java
RUN apt-get install -y wget openssh-server openjdk-8-jdk

# Set SSH passwordless login
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
RUN sed -i 's/#   StrictHostKeyChecking ask/StrictHostKeyChecking accept-new/' /etc/ssh/ssh_config

# Download  Hadoop
RUN cd /usr/local && wget -O ./hadoop.tar.gz https://downloads.apache.org/hadoop/common/hadoop-3.3.1/hadoop-3.3.1.tar.gz && tar -xvf hadoop.tar.gz && chown root: -R /usr/local/hadoop-3.3.1 && mv hadoop-3.3.1 hadoop

RUN echo -e $'# JAVA set environment variables\n\
JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64\n\
# Set HADOOP_HOME\n\
HADOOP_HOME=/usr/local/hadoop\n\
# Set HADOOP_MAPRED_HOME\n\
HADOOP_MAPRED_HOME=${HADOOP_HOME}\n\
# Add Hadoop bin and sbin directory to PATH\n\
PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin' >> /root/.bashrc && source /root/.bashrc

# Set hadoop-env.sh
RUN sed -i '55s@.*@export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64@g' /usr/local/hadoop/etc/hadoop/hadoop-env.sh
RUN sed -i '59s@.*@export HADOOP_HOME=/usr/local/hadoop@g' /usr/local/hadoop/etc/hadoop/hadoop-env.sh
RUN sed -i '69s@.*@export HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop@g' /usr/local/hadoop/etc/hadoop/hadoop-env.sh

# Set User in hadoop-env.sh
RUN sed -i '319s@.*@export HDFS_DATANODE_SECURE_USER=root@g' /usr/local/hadoop/etc/hadoop/hadoop-env.sh
RUN sed -i '348s@.*@export HDFS_NFS3_SECURE_USER=root@g' /usr/local/hadoop/etc/hadoop/hadoop-env.sh
RUN sed -i '418s@.*@export HDFS_NAMENODE_USER=root@g' /usr/local/hadoop/etc/hadoop/hadoop-env.sh
RUN sed -i '426s@.*@export HADOOP_REGISTRYDNS_SECURE_USER=root@g' /usr/local/hadoop/etc/hadoop/hadoop-env.sh
RUN echo -e $'export HDFS_SECONDARYNAMENODE_USER=root' >> /usr/local/hadoop/etc/hadoop/hadoop-env.sh
RUN echo -e $'export HADOOP_SHELL_EXECNAME=root' >> /usr/local/hadoop/etc/hadoop/hadoop-env.sh
RUN echo -e $'export YARN_RESOURCEMANAGER_USER=root' >> /usr/local/hadoop/etc/hadoop/hadoop-env.sh
RUN echo -e $'export YARN_NODEMANAGER_USER=root' >> /usr/local/hadoop/etc/hadoop/hadoop-env.sh
RUN echo -e $'export HDFS_JOURNALNODE_USER=root' >> /usr/local/hadoop/etc/hadoop/hadoop-env.sh
RUN echo -e $'export HDFS_ZKFC_USER=root' >> /usr/local/hadoop/etc/hadoop/hadoop-env.sh

# Set workers
RUN echo -e $'worker1\n\
worker2\n\
worker3\n\
worker4\n\
worker5\n\
worker6' >> /usr/local/hadoop/etc/hadoop/workers

# Set core-site.xml, mapred-site.xml, yarn-site.xml, hdfs-site.xml
COPY ./core-site.xml /usr/local/hadoop/etc/hadoop/core-site.xml
COPY ./mapred-site.xml /usr/local/hadoop/etc/hadoop/mapred-site.xml
COPY ./yarn-site.xml /usr/local/hadoop/etc/hadoop/yarn-site.xml
COPY ./hdfs-site.xml /usr/local/hadoop/etc/hadoop/hdfs-site.xml

# Start start-dfs.sh
RUN echo -e $'export HADOOP_OPTS="$HADOOP_OPTS -Djava.net.preferIPv4Stack=true -Djava.security.krb5.realm= -Djava.security.krb5.kdc="' >> /usr/local/hadoop/etc/hadoop/hadoop-env.sh

# Set file for NN INFO
RUN mkdir -p /usr/local/hadoop/data/dfs/name /usr/local/hadoop/data/journalnode /usr/local/hadoop/data/namenode /usr/local/hadoop/data/datanode

# Remove downloaded hadoop file
RUN rm /usr/local/hadoop.tar.gz

EXPOSE 22 9870 9868 8020
