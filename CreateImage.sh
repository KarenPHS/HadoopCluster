#!/bin/bash

cd ./hadoop_basic
docker image build -t basichadoop . --no-cache
cd ..

cd ./Worker1
docker image build -t hsuan8169/workers . --no-cache
cd ..

cd ./Spark
docker image build -t hsuan8169/spark . --no-cache
cd ..

cd ./JournalNode1
docker image build -t hsuan8169/journalnode1 . --no-cache
cd ..

cd ./JournalNode2
docker image build -t hsuan8169/journalnode2 . --no-cache
cd ..

cd ./JournalNode3
docker image build -t hsuan8169/journalnode3 . --no-cache
cd ..
