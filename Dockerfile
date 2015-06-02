FROM ubuntu
MAINTAINER LionHeart <LionHeart_fxc@163.com>
ENV REFRESHED_AT 2015-04-19
RUN apt-get update
RUN apt-get install -y make
RUN apt-get install -y libc6
RUN apt-get install -y libc6-dev
RUN apt-get install -y g++
RUN apt-get install -y build-essential
RUN apt-get install unzip
RUN apt-get -y install libpcre3 libpcre3-dev
RUN apt-get -y install ruby zlib1g zlib1g.dev
RUN mkdir -p /home/fastdfs
RUN mkdir -p /home/fastdfs_file/data
RUN ln -s /home/fastdfs_file/data /home/fastdfs_file/data/M00
WORKDIR /home/fastdfs
ADD file/fastdfs-5.05.tar.gz /home/fastdfs
ADD file/libfastcommon-master.zip /home/fastdfs/
ADD file/nginx-1.6.3.tar.gz /home/fastdfs
ADD file/ngx_cache_purge-2.3.tar.gz /home/fastdfs
RUN unzip libfastcommon-master.zip
WORKDIR /home/fastdfs/libfastcommon-master
RUN ./make.sh
RUN ./make.sh install
WORKDIR /home/fastdfs/fastdfs-5.05
RUN ./make.sh
RUN ./make.sh install
WORKDIR /home/fastdfs/nginx-1.6.3
RUN ./configure --add-module=/home/fastdfs/ngx_cache_purge-2.3
RUN make
RUN make install
WORKDIR /etc/ld.so.conf.d/
RUN touch libfastcommon.conf
RUN echo "/usr/lib64/" >> libfastcommon.conf
RUN /sbin/ldconfig -v
RUN cp /home/fastdfs/fastdfs-5.05/conf/http.conf /etc/fdfs/
RUN cp /home/fastdfs/fastdfs-5.05/conf/mime.types /etc/fdfs/
WORKDIR /home/fastdfs/fastdfs-5.05
EXPOSE 80
