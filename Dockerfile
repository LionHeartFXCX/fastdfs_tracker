FROM ubuntu

MAINTAINER LionHeart <LionHeart_fxc@163.com>

ENV FASTDFS_PATH=/fastDFS \
    FASTDFS_BASE_PATH=/data

RUN apt-get update && apt-get install -y \
    gcc \
    git \
    make 

RUN mkdir -p ${FASTDFS_PATH}/libfastcommon \
 && mkdir -p ${FASTDFS_PATH}/fastdfs \
 && mkdir ${FASTDFS_BASE_PATH}

RUN git clone https://github.com/happyfish100/libfastcommon.git ${FASTDFS_PATH}/libfastcommon \
 && git clone https://github.com/happyfish100/fastdfs.git ${FASTDFS_PATH}/fastdfs
 
WORKDIR ${FASTDFS_PATH}/libfastcommon

RUN ["/bin/bash", "-c", "./make.sh && ./make.sh install"]

WORKDIR ${FASTDFS_PATH}/fastdfs

RUN ["/bin/bash", "-c", "./make.sh && ./make.sh install"]

EXPOSE 22122