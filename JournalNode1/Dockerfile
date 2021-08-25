FROM hsuan8169/hadoopha
MAINTAINER Hsuan hsuan8169@gmail.com

USER root

# Download journalnode
RUN cd /usr/local && wget -O ./zookeeper.tar.gz https://downloads.apache.org/zookeeper/zookeeper-3.6.3/apache-zookeeper-3.6.3-bin.tar.gz && tar -xvf zookeeper.tar.gz && chown root: -R /usr/local/apache-zookeeper-3.6.3-bin && mv apache-zookeeper-3.6.3-bin zookeeper

# Set Zookeeper
RUN cd /usr/local/zookeeper/conf && cp zoo_sample.cfg zoo.cfg
RUN sed -i '12s@.*@dataDir=/usr/local/zookeeper/zoodata@g' /usr/local/zookeeper/conf/zoo.cfg
RUN sed -i '17s@#maxClientCnxns=60@maxClientCnxns=60@g' /usr/local/zookeeper/conf/zoo.cfg
RUN echo -e $'admin.serverPort=8010\n\
server.1=journalnode1:2888:3888\n\
server.2=journalnode2:2888:3888\n\
server.3=journalnode3:2888:3888' >> /usr/local/zookeeper/conf/zoo.cfg

# Set zkEnv.sh
RUN sed -i '30iZOO_LOG_DIR="/usr/local/zookeeper/logs"' /usr/local/zookeeper/bin/zkEnv.sh
RUN sed -i '31iZOO_LOG4J_PROP="INFO,ROLLINGFILE"' /usr/local/zookeeper/bin/zkEnv.sh

# Build NN HA File
RUN mkdir /usr/local/hadoop/journalnode
# Build RM HA Fiel
RUN mkdir /usr/local/zookeeper/zoodata && echo -e $'1' > /usr/local/zookeeper/zoodata/myid

RUN echo -e $'# Add Zookeeper_HOME\n\
export ZOOKEEPER_HOME=/usr/local/zookeeper\n\
# Add Zookeeper_CONF\n\
export ZOOKEEPER_CONF=/usr/local/zookeeper/conf\n\
# Add Zookeeper PATH\n\
export PATH=$PATH:$ZOOKEEPER_HOME/bin' >> /root/.bashrc && source /root/.bashrc

# Remove downloaded zookeeper file
RUN rm /usr/local/zookeeper.tar.gz
