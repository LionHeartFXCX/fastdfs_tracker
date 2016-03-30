FROM debain

MAINTAINER LionHeart <LionHeart_fxc@163.com>

ENV FASTDFS_PATH=/fastDFS \
    FASTDFS_BASE_PATH=/data

#get all the dependences
RUN apt-get update && apt-get install -y \
    gcc \
    git \
    make \
 && rm -rf /var/lib/apt/lists/*

ADD start.sh /usr/bin/

#create the directory and change the make the start.sh executable
RUN chmod 777 /usr/bin/start.sh
 && mkdir -p ${FASTDFS_PATH}/libfastcommon \
 && mkdir -p ${FASTDFS_PATH}/fastdfs \
 && mkdir ${FASTDFS_BASE_PATH} \

#compile the libfastcommon
WORKDIR ${FASTDFS_PATH}/libfastcommon

RUN /bin/bash -c 'git clone https://github.com/happyfish100/libfastcommon.git ${FASTDFS_PATH}/libfastcommon ;\
  ./make.sh ;\
  ./make.sh install ;\
  rm -rf ${FASTDFS_PATH}/libfastcommon'

#compile the fastdfs
WORKDIR ${FASTDFS_PATH}/fastdfs

RUN /bin/bash -c 'git clone https://github.com/happyfish100/fastdfs.git ${FASTDFS_PATH}/fastdfs ;\
 ./make.sh ;\
 ./make.sh install ;\
 rm -rf ${FASTDFS_PATH}/fastdfs'

EXPOSE 22122

ENTRYPOINT ["/usr/bin/start.sh"]
