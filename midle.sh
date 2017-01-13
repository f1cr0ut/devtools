#!/bin/bash
if [ $# -ne 1 ]; then
	echo "input prefix dir without last / like:"
	echo "/home/username/local"
	exit 1
fi

# build zlib
wget http://zlib.net/zlib-1.2.10.tar.gz
tar zxf zlib-1.2.10.tar.gz
cd zlib-1.2.10
./configure --prefix=$1
make -j32
cd ../

# build nginx
wget http://nginx.org/download/nginx-1.11.8.tar.gz
git clone https://github.com/agentzh/headers-more-nginx-module/
wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.40.tar.gz
tar zxf nginx-1.11.8.tar.gz
tar zxf pcre-8.40.tar.gz
cd nginx-1.11.8
./configure --prefix=$1 --add-module=../headers-more-nginx-module/ --with-pcre=../pcre-8.40 --with-zlib=../zlib-1.2.10
make -j32
make -j32 install
cd ../
rm -rf nginx-1.11.8* headers-more-nginx-module* pcre-8.40* *zlib-1.2.10*
