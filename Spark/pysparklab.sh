#!/bin/bash

export PYSPARK_DRIVER_PYTHON="jupyter"
export PYSPARK_DRIVER_PYTHON_OPTS="lab --no-browser --port=8888"

# localmode
# pyspark --master local[*]

# standalone cluster
#pyspark --master spark://bdse100.example.org:7077 \
   --driver-memory 1G \
   --driver-cores 1 \
   --executor-memory 1G \
   --executor-cores 1 \
   --num-executors 2 \
   --deploy-mode client
   
# Start on YARN
pyspark --master yarn \
   --driver-memory 12G \
   --driver-cores 10 \
   --executor-memory 12G \
   --executor-cores 10 \
   --num-executors 3   \
   --deploy-mode client
