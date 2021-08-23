#!/bin/bash

# [Zookeeper start]
docker exec -i journalnode1 /bin/bash -c  "/usr/local/zookeeper/bin/zkServer.sh start" && docker exec -i journalnode2 /bin/bash -c  "/usr/local/zookeeper/bin/zkServer.sh start" && docker exec -i journalnode3 /bin/bash -c  "/usr/local/zookeeper/bin/zkServer.sh start"
sleep 10

# [Journal start]
docker exec -i journalnode1 /bin/bash -c  "/usr/local/hadoop/bin/hdfs --daemon start journalnode" && docker exec -i journalnode2 /bin/bash -c  "/usr/local/hadoop/bin/hdfs --daemon start journalnode" && docker exec -i journalnode3 /bin/bash -c  "/usr/local/hadoop/bin/hdfs --daemon start journalnode"
sleep 10
# [NN format]
docker exec -i active-nn /bin/bash -c "/usr/local/hadoop/bin/hdfs namenode -format"
sleep 10
# [NN zookeeper format]
docker exec -i active-nn /bin/bash -c  "/usr/local/hadoop/bin/hdfs zkfc -formatZK"
sleep 10
# [NN start]
docker exec -i active-nn /bin/bash -c "/usr/local/hadoop/bin/hdfs --daemon start namenode"
sleep 10
# [Standby get data]
docker exec -i standby-nn /bin/bash -c "/usr/local/hadoop/bin/hdfs namenode -bootstrapStandby"
sleep 10
# [NN stop]
docker exec -i active-nn /bin/bash -c "/usr/local/hadoop/bin/hdfs --daemon stop namenode"
sleep 10
# [Journal stop]
docker exec -i journalnode1 /bin/bash -c  "/usr/local/hadoop/bin/hdfs --daemon stop journalnode" && docker exec -i journalnode2 /bin/bash -c  "/usr/local/hadoop/bin/hdfs --daemon stop journalnode" && docker exec -i journalnode3 /bin/bash -c  "/usr/local/hadoop/bin/hdfs --daemon stop journalnode"
sleep 20
# [All NN start]
docker exec -i active-nn /bin/bash -c "/usr/local/hadoop/sbin/start-dfs.sh"
sleep 10
# [RM && HS start]
docker exec -i active-rm /bin/bash -c "/usr/local/hadoop/sbin/start-yarn.sh"
sleep 10
docker exec -i historyserver /bin/bash -c "/usr/local/hadoop/bin/mapred --daemon start historyserver"
sleep 10