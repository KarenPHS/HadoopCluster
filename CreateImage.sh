#!/bin/bash

cd /home/hsuan8169/HadoopCluster/Active_NN
docker image build -t hsuan8169/active-nn . --no-cache
cd /home/hsuan8169/HadoopCluster/Active_RM
docker image build -t hsuan8169/active-rm . --no-cache
cd /home/hsuan8169/HadoopCluster/HistoryServer
docker image build -t hsuan8169/historyserver . --no-cache
cd /home/hsuan8169/HadoopCluster/Worker1
docker image build -t hsuan8169/workers . --no-cache
cd /home/hsuan8169/HadoopCluster/Spark
docker image build -t hsuan8169/spark . --no-cache
cd /home/hsuan8169/HadoopCluster/JournalNode1
docker image build -t hsuan8169/journalnode1 . --no-cache
cd /home/hsuan8169/HadoopCluster/JournalNode2
docker image build -t hsuan8169/journalnode2 . --no-cache
cd /home/hsuan8169/HadoopCluster/JournalNode3
docker image build -t hsuan8169/journalnode3 . --no-cache
cd /home/hsuan8169/HadoopCluster
