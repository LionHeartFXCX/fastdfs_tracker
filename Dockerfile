FROM ubuntu

MAINTAINER LionHeart <LionHeart_fxc@163.com>

ENV FASTDFS_PATH=/fastDFS \
    FASTDFS_BASE_PATH=/data

RUN apt-get update && apt-get install -y \
    gcc \
    git \
    make \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p ${FASTDFS_PATH}/libfastcommon \
 && mkdir -p ${FASTDFS_PATH}/fastdfs \
 && mkdir ${FASTDFS_BASE_PATH}

RUN /bin/bash -c 'git clone https://github.com/happyfish100/libfastcommon.git ${FASTDFS_PATH}/libfastcommon ;\
  ${FASTDFS_PATH}/libfastcommon/make.sh ;\
  ${FASTDFS_PATH}/libfastcommon/make.sh install ;\
  git clone https://github.com/happyfish100/fastdfs.git ${FASTDFS_PATH}/fastdfs ;\
  ${FASTDFS_PATH}/libfastcommon/make.sh ;\
  ${FASTDFS_PATH}/libfastcommon/make.sh install ;\
  rm -rf ${FASTDFS_PATH}'

EXPOSE 22122
