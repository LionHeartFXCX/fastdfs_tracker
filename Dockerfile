FROM ubuntu

MAINTAINER LionHeart <LionHeart_fxc@163.com>

ENV FASTDFS_PATH=/fastDFS
ENV FASTDFS_BASE_PATH=/data

RUN apt-get update
RUN apt-get install -y gcc 
RUN apt-get install -y git
RUN apt-get install -y make

RUN mkdir -p ${FASTDFS_PATH}/libfastcommon
RUN mkdir -p ${FASTDFS_PATH}/fastdfs
RUN mkdir ${FASTDFS_BASE_PATH}

RUN git clone https://github.com/happyfish100/libfastcommon.git ${FASTDFS_PATH}/libfastcommon
RUN git clone https://github.com/happyfish100/fastdfs.git ${FASTDFS_PATH}/fastdfs

WORKDIR ${FASTDFS_PATH}/libfastcommon

RUN ["/bin/bash", "-c", "./make.sh"]
RUN ["/bin/bash", "-c", "./make.sh install"]

WORKDIR ${FASTDFS_PATH}/fastdfs

RUN ["/bin/bash", "-c", "./make.sh"]
RUN ["/bin/bash", "-c", "./make.sh install"]

EXPOSE 22122

ADD start.sh /usr/bin/
RUN chmod 777 /usr/bin/start.sh

ENTRYPOINT ["/usr/bin/start.sh"]