#!/bin/bash

cd /home/hsuan8169/HadoopCluster/Active_NN
docker image build -t hsuan8169/active-nn .
cd /home/hsuan8169/HadoopCluster/Active_RM
docker image build -t hsuan8169/active-rm .
cd /home/hsuan8169/HadoopCluster/HistoryServer
docker image build -t hsuan8169/historyserver .
cd /home/hsuan8169/HadoopCluster/Worker1
docker image build -t hsuan8169/workers .
cd /home/hsuan8169/HadoopCluster/Spark
docker image build -t hsuan8169/spark .
cd /home/hsuan8169/HadoopCluster/JournalNode1
docker image build -t hsuan8169/journalnode1 .
cd /home/hsuan8169/HadoopCluster/JournalNode2
docker image build -t hsuan8169/journalnode2 .
cd /home/hsuan8169/HadoopCluster/JournalNode3
docker image build -t hsuan8169/journalnode3 .
cd /home/hsuan8169/HadoopCluster
