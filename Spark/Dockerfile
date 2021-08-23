FROM basichadoop
MAINTAINER Hsuan hsuan8169@gmail.com

USER root

RUN apt-get -y install python3-pip

# Download  Spak
RUN cd /usr/local && wget -O ./spark.tar.gz https://downloads.apache.org/spark/spark-3.0.3/spark-3.0.3-bin-hadoop2.7.tgz && tar -xvf spark.tar.gz && chown root: -R /usr/local/spark-3.0.3-bin-hadoop2.7 && mv spark-3.0.3-bin-hadoop2.7 spark

RUN echo -e $'# Set Spark environment\n\
export SPARK_HOME="/usr/local/spark"\n\
export PATH="$SPARK_HOME/bin:$PATH"' >> /root/.bashrc && source /root/.bashrc

# Set spark-env.sh
RUN cp /usr/local/spark/conf/spark-env.sh.template /usr/local/spark/conf/spark-env.sh && \
echo -e $'# Set pyspark python\n\
export PYSPARK_PYTHON="/usr/bin/python3"\n\
# Koalas env variable\n\
export PYARROW_IGNORE_TIMEZONE=1\n\
# Spark on YARN\n\
export HADOOP_CONF_DIR="/usr/local/hadoop/ect/hadoop"'>> /usr/local/spark/conf/spark-env.sh

# Set spark-defaults.conf
RUN cp /usr/local/spark/conf/spark-defaults.conf.template /usr/local/spark/conf/spark-defaults.conf && \
echo -e $'spark.driver.extraJavaOptions="-Dio.netty.tryReflectionSetAccessible=true"\n\
spark.executor.extraJavaOptions="-Dio.netty.tryReflectionSetAccessible=true"'>> /usr/local/spark/conf/spark-defaults.conf

# install package
RUN pip install jupyterlab pandas koalas pyspark

# Set jupyter Notebook
RUN jupyter lab --generate-config
RUN sed -i "757s@.*@c.ServerApp.ip = '*'@g" /root/.jupyter/jupyter_lab_config.py
RUN sed -i '608s@.*@c.ServerApp.allow_root = True@g' /root/.jupyter/jupyter_lab_config.py

# Set pyspark.sh, sparkcodes
COPY ./pysparklab.sh /usr/local/hadoop/pysparklab.sh
COPY ./sparkcodes /usr/local/hadoop/sparkcodes

# Remove downloaded spark file
RUN rm /usr/local/spark.tar.gz

EXPOSE 4040 8888 8080 7077
