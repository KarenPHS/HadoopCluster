#!/bin/bash

# [Zookeeper start]
docker exec -i journalnode1 /bin/bash -c  "/usr/local/zookeeper/bin/zkServer.sh start" && docker exec -i journalnode2 /bin/bash -c  "/usr/local/zookeeper/bin/zkServer.sh start" && docker exec -i journalnode3 /bin/bash -c  "/usr/local/zookeeper/bin/zkServer.sh start"
sleep 5

# [Journal start]
docker exec -i journalnode1 /bin/bash -c  "/usr/local/hadoop/bin/hdfs --daemon start journalnode" && docker exec -i journalnode2 /bin/bash -c  "/usr/local/hadoop/bin/hdfs --daemon start journalnode" && docker exec -i journalnode3 /bin/bash -c  "/usr/local/hadoop/bin/hdfs --daemon start journalnode"
sleep 5
# [NN format]
docker exec -i active-nn /bin/bash -c "/usr/local/hadoop/bin/hdfs namenode -format"
sleep 5
# [NN zookeeper format]
docker exec -i active-nn /bin/bash -c  "/usr/local/hadoop/bin/hdfs zkfc -formatZK"
sleep 5
# [NN start]
docker exec -i active-nn /bin/bash -c "/usr/local/hadoop/bin/hdfs --daemon start namenode"
sleep 5
# [Standby get data]
docker exec -i standby-nn /bin/bash -c "/usr/local/hadoop/bin/hdfs namenode -bootstrapStandby"
sleep 5
# [NN stop]
docker exec -i active-nn /bin/bash -c "/usr/local/hadoop/bin/hdfs --daemon stop namenode"
sleep 5
# [Journal stop]
docker exec -i journalnode1 /bin/bash -c  "/usr/local/hadoop/bin/hdfs --daemon stop journalnode" && docker exec -i journalnode2 /bin/bash -c  "/usr/local/hadoop/bin/hdfs --daemon stop journalnode" && docker exec -i journalnode3 /bin/bash -c  "/usr/local/hadoop/bin/hdfs --daemon stop journalnode"
sleep 5
# [All NN start]
docker exec -i active-nn /bin/bash -c "/usr/local/hadoop/sbin/start-dfs.sh"
sleep 5
# [RM && HS start]
docker exec -i active-rm /bin/bash -c "/usr/local/hadoop/sbin/start-yarn.sh"
sleep 5
docker exec -i historyserver /bin/bash -c "/usr/local/hadoop/bin/mapred --daemon start historyserver"
sleep 5
# Initial Hive
docker exec -i active-nn /bin/bash -c "/usr/local/hive/bin/schematool -initSchema -dbType derby"
sleep 5
# Set hive needed file# Make hive file
docker exec -i active-nn /bin/bash -c "/usr/local/hadoop/bin/hdfs dfs -mkdir -p /tmp"
docker exec -i active-nn /bin/bash -c "/usr/local/hadoop/bin/hdfs dfs -mkdir -p /user/hive/warehouse"
