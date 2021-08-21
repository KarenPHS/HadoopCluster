FROM BasicHadoop
MAINTAINER Hsuan hsuan8169@gmail.com

USER root

# Set core-site.xml, mapred-site.xml, yarn-site.xml, hdfs-site.xml
COPY ./core-site.xml /usr/local/hadoop/etc/hadoop/core-site.xml
COPY ./mapred-site.xml /usr/local/hadoop/etc/hadoop/mapred-site.xml
COPY ./yarn-site.xml /usr/local/hadoop/etc/hadoop/yarn-site.xml
COPY ./hdfs-site.xml /usr/local/hadoop/etc/hadoop/hdfs-site.xml

EXPOSE 22 19888 10020
