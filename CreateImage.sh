#!/bin/bash

cd /home/hsuan8169/HadoopCluster/Active_NN
docker image build -t hsuan8169/active_nn .
cd /home/hsuan8169/HadoopCluster/Active_RM
docker image build -t hsuan8169/active_rm .
cd /home/hsuan8169/HadoopCluster/HistoryServer
docker image build -t hsuan8169/historyserver .
cd /home/hsuan8169/HadoopCluster/Worker1
docker image build -t hsuan8169/workers .