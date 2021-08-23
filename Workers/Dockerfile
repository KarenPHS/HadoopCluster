FROM hsuan8169/hadoopha
MAINTAINER Hsuan hsuan8169@gmail.com

USER root

# install package
RUN apt-get -y install python3-pip
RUN /usr/bin/pip install pandas koalas pyspark

EXPOSE 22 9864 9866 9867 8040 8042
