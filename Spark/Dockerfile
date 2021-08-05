FROM ubuntu:20.04
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
MAINTAINER Hsuan hsuan8169@gmail.com

USER root

RUN apt-get update

# Set Timezone
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tcl && echo "Asia/Taipei" > /etc/timezone

# First, set timezone, and then install java, python pip 
RUN apt-get install -y wget openssh-server openjdk-8-jdk python3-pip

# Set SSH passwordless login
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys && \
sed -i 's/PermitEmptyPasswords yes/PermitEmptyPasswords no /' /etc/ssh/sshd_config && \
sed -i 's/PermitRootLogin without-password/PermitRootLogin yes /' /etc/ssh/sshd_config && \
echo " StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \
echo " UserKnownHostsFile /dev/null" >> /etc/ssh/ssh_config && \
echo "root:hadoop" | chpasswd

# Download  Hadoop
RUN cd /usr/local && wget -O ./hadoop.tar.gz https://downloads.apache.org/hadoop/common/hadoop-3.3.1/hadoop-3.3.1.tar.gz && tar -xvf hadoop.tar.gz && chown root: -R /usr/local/hadoop-3.3.1 && mv hadoop-3.3.1 hadoop

# Download  Spak
RUN cd /usr/local && wget -O ./spark.tar.gz https://downloads.apache.org/spark/spark-3.0.3/spark-3.0.3-bin-hadoop2.7.tgz && tar -xvf spark.tar.gz && chown root: -R /usr/local/spark-3.0.3-bin-hadoop2.7 && mv spark-3.0.3-bin-hadoop2.7 spark

RUN echo -e $'# JAVA set environment variables\n\
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64\n\
# Set HADOOP_HOME\n\
HADOOP_HOME=/usr/local/hadoop\n\
# Set HADOOP_MAPRED_HOME\n\
HADOOP_MAPRED_HOME=${HADOOP_HOME}\n\
# Add Hadoop bin and sbin directory to PATH\n\
PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin\n\
# Set Spark environment\n\
export SPARK_HOME="/usr/local/spark"\n\
export PATH="$SPARK_HOME/bin:$PATH"
' >> /root/.bashrc && source /root/.bashrc

# Set spark-env.sh
RUN cp /usr/local/spark/conf/spark-env.sh.template /usr/local/spark/conf/spark-env.sh && \
echo -e $'# Set pyspark python\n\
export PYSPARK_PYTHON="/usr/bin/python3"\n\
# Koalas env variable\n\
export PYARROW_IGNORE_TIMEZONE=1\n\
# Spark on YARN\n\
export HADOOP_CONF_DIR="/usr/local/hadoop/ect/hadoop"'>> /usr/local/spark/conf/spark-env.sh

# Set spark-defaults.conf
RUN cp /usr/local/spark/conf/spark-defaults.conf.template /usr/local/spark/conf/spark-defaults.conf && \
echo -e $'spark.driver.extraJavaOptions="-Dio.netty.tryReflectionSetAccessible=true"\n\
spark.executor.extraJavaOptions="-Dio.netty.tryReflectionSetAccessible=true"'>> /usr/local/spark/conf/spark-defaults.conf

# install package
RUN pip install jupyterlab pandas koalas

# Set jupyter Notebook
RUN jupyter lab --generate-config
RUN sed -i "757s@.*@c.ServerApp.ip = '*'@g" /root/.jupyter/jupyter_lab_config.py

# Set hadoop-env.sh
RUN sed -i '55s@.*@JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64@g' /usr/local/hadoop/etc/hadoop/hadoop-env.sh
RUN sed -i '59s@.*@HADOOP_HOME=/usr/local/hadoop@g' /usr/local/hadoop/etc/hadoop/hadoop-env.sh
RUN sed -i '69s@.*@HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop@g' /usr/local/hadoop/etc/hadoop/hadoop-env.sh

# Set User in hadoop-env.sh
RUN sed -i '319s@.*@export HDFS_DATANODE_SECURE_USER=root@g' /usr/local/hadoop/etc/hadoop/hadoop-env.sh
RUN sed -i '348s@.*@export HDFS_NFS3_SECURE_USER=root@g' /usr/local/hadoop/etc/hadoop/hadoop-env.sh
RUN sed -i '418s@.*@export HDFS_NAMENODE_USER=root@g' /usr/local/hadoop/etc/hadoop/hadoop-env.sh
RUN sed -i '426s@.*@export HADOOP_REGISTRYDNS_SECURE_USER=root@g' /usr/local/hadoop/etc/hadoop/hadoop-env.sh
RUN echo -e $'export HDFS_SECONDARYNAMENODE_USER=root' >> /usr/local/hadoop/etc/hadoop/hadoop-env.sh
RUN echo -e $'export HADOOP_SHELL_EXECNAME=root' >> /usr/local/hadoop/etc/hadoop/hadoop-env.sh
RUN echo -e $'export YARN_RESOURCEMANAGER_USER=root' >> /usr/local/hadoop/etc/hadoop/hadoop-env.sh
RUN echo -e $'export YARN_NODEMANAGER_USER=root' >> /usr/local/hadoop/etc/hadoop/hadoop-env.sh

# Set workers
RUN echo -e $'worker1\n\
worker2\n\
worker3\n\
worker4\n\
worker5\n\
worker6' >> /usr/local/hadoop/etc/hadoop/workers

# Set core-site.xml, mapred-site.xml, yarn-site.xml, hdfs-site.xml, pyspark.sh
COPY ./core-site.xml /usr/local/hadoop/etc/hadoop/core-site.xml
COPY ./mapred-site.xml /usr/local/hadoop/etc/hadoop/mapred-site.xml
COPY ./yarn-site.xml /usr/local/hadoop/etc/hadoop/yarn-site.xml
COPY ./hdfs-site.xml /usr/local/hadoop/etc/hadoop/hdfs-site.xml
COPY ./pyspark.sh /usr/local/hadoop/pyspark.sh

# Start start-dfs.sh
RUN echo -e $'export HADOOP_OPTS="$HADOOP_OPTS -Djava.net.preferIPv4Stack=true -Djava.security.krb5.realm= -Djava.security.krb5.kdc="' >> /usr/local/hadoop/etc/hadoop/hadoop-env.sh

# Remove downloaded file
RUN rm /usr/local/hadoop.tar.gz
RUN rm /usr/local/spark.tar.gz

EXPOSE 4040 8888 8080