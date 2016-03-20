FROM ubuntu

MAINTAINER LionHeart <LionHeart_fxc@163.com>

ENV FASTDFS_PATH=/fastDFS \
    FASTDFS_BASE_PATH=/data
    
ADD start.sh /usr/bin/

RUN apt-get update && apt-get install -y \
    gcc \
    git \
    make \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p ${FASTDFS_PATH}/libfastcommon \
 && mkdir -p ${FASTDFS_PATH}/fastdfs \
 && mkdir ${FASTDFS_BASE_PATH} \
 && chmod 777 /usr/bin/start.sh

WORKDIR ${FASTDFS_PATH}/libfastcommon

RUN /bin/bash -c 'git clone https://github.com/happyfish100/libfastcommon.git ${FASTDFS_PATH}/libfastcommon ;\
  ./make.sh ;\
  ./make.sh install ;\
  rm -rf ${FASTDFS_PATH}/libfastcommon'

WORKDIR ${FASTDFS_PATH}/fastdfs

RUN /bin/bash -c 'git clone https://github.com/happyfish100/fastdfs.git ${FASTDFS_PATH}/fastdfs ;\
 ./make.sh ;\
 ./make.sh install ;\
 rm -rf ${FASTDFS_PATH}/fastdfs'

EXPOSE 22122

ENTRYPOINT ["/usr/bin/start.sh"]
