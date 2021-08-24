#!/bin/bash

# [Zookeeper start]
echo "Starting Zookeeper on journalnode1, journalnode2 and journalnode3..."
docker exec -i journalnode1 /bin/bash -c  "/usr/local/zookeeper/bin/zkServer.sh start" && docker exec -i journalnode2 /bin/bash -c  "/usr/local/zookeeper/bin/zkServer.sh start" && docker exec -i journalnode3 /bin/bash -c  "/usr/local/zookeeper/bin/zkServer.sh start"
sleep 2

# [Journal start]
echo "Starting Journalnode on journalnode1, journalnode2 and journalnode3..."
docker exec -i journalnode1 /bin/bash -c  "/usr/local/hadoop/bin/hdfs --daemon start journalnode" && docker exec -i journalnode2 /bin/bash -c  "/usr/local/hadoop/bin/hdfs --daemon start journalnode" && docker exec -i journalnode3 /bin/bash -c  "/usr/local/hadoop/bin/hdfs --daemon start journalnode"
sleep 2

# [NN format]
echo "NameNode formating..."
docker exec -i active-nn /bin/bash -c "/usr/local/hadoop/bin/hdfs namenode -format"
sleep 2

# [NN zookeeper format]
echo "Zookeeper formating..."
docker exec -i active-nn /bin/bash -c  "/usr/local/hadoop/bin/hdfs zkfc -formatZK"
sleep 2

# [NN start]
echo "Namenode starting on active-nn..."
docker exec -i active-nn /bin/bash -c "/usr/local/hadoop/bin/hdfs --daemon start namenode"
sleep 2

# [Standby get data]
echo "Getting from active-nn..."
docker exec -i standby-nn /bin/bash -c "/usr/local/hadoop/bin/hdfs namenode -bootstrapStandby"
sleep 2

# [NN stop]
echo "Stoping NN on active-nn..."
docker exec -i active-nn /bin/bash -c "/usr/local/hadoop/bin/hdfs --daemon stop namenode"
sleep 2

# [Journal stop]
echo "Stoping all Journalnode"
docker exec -i journalnode1 /bin/bash -c  "/usr/local/hadoop/bin/hdfs --daemon stop journalnode" && docker exec -i journalnode2 /bin/bash -c  "/usr/local/hadoop/bin/hdfs --daemon stop journalnode" && docker exec -i journalnode3 /bin/bash -c  "/usr/local/hadoop/bin/hdfs --daemon stop journalnode"
sleep 2

# [All NN start]
echo "Starting NN & workers and then conneting to "
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
