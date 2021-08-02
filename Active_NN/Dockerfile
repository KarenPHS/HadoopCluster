FROM ubuntu:20.04

MAINTAINER Hsuan hsuan8169@gmail.com

USER root

RUN apt-get update

# Set Timezone
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tcl && echo "Asia/Taipei" > /etc/timezone

# First, set timezone, and then install java 
RUN apt-get install -y wget openssh-server openjdk-8-jdk

# Set SSH passwordless login
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys && \
sed -i 's/PermitEmptyPasswords yes/PermitEmptyPasswords no /' /etc/ssh/sshd_config && \
sed -i 's/PermitRootLogin without-password/PermitRootLogin yes /' /etc/ssh/sshd_config && \
echo " StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \
echo " UserKnownHostsFile /dev/null" >> /etc/ssh/ssh_config && \
echo "root:hadoop" | chpasswd

# Download  Hadoop
RUN cd /usr/local && wget -O ./hadoop.tar.gz https://downloads.apache.org/hadoop/common/hadoop-3.3.1/hadoop-3.3.1.tar.gz && tar -xvf hadoop.tar.gz && chown root: -R /usr/local/hadoop-3.3.1 && mv hadoop-3.3.1 hadoop

RUN echo -e $'# JAVA set environment variables\n\
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64\n\
# Set HADOOP_HOME\n\
HADOOP_HOME=/usr/local/hadoop\n\
# Set HADOOP_MAPRED_HOME\n\
HADOOP_MAPRED_HOME=${HADOOP_HOME}\n\
# Add Hadoop bin and sbin directory to PATH\n\
PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin' >> /root/.bashrc && source /root/.bashrc

# Set hadoop-env.sh
RUN sed -i '55s@.*@JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64@g' /usr/local/hadoop/etc/hadoop/hadoop-env.sh
RUN sed -i '59s@.*@HADOOP_HOME=/usr/local/hadoop@g' /usr/local/hadoop/etc/hadoop/hadoop-env.sh
RUN sed -i '69s@.*@HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop@g' /usr/local/hadoop/etc/hadoop/hadoop-env.sh

# Set workers
RUN echo -e $'Worker1\n\
Worker2\n\
Worker3\n\
Worker4\n\
Worker5\n\
Worker6' >> /usr/local/hadoop/etc/hadoop/workers 

# Set core-site.xml, mapred-site.xml, yarn-site.xml, hdfs-site.xml
COPY ./core-site.xml /usr/local/hadoop/etc/hadoop/core-site.xml
COPY ./core-site.xml /usr/local/hadoop/etc/hadoop/mapred-site.xml
COPY ./core-site.xml /usr/local/hadoop/etc/hadoop/yarn-site.xml
COPY ./core-site.xml /usr/local/hadoop/etc/hadoop/hdfs-site.xml

EXPOSE 22 9868 9870 8020