#!/bin/bash
if [ $# -ne 1 ]; then
	echo "input prefix dir without last / like:"
	echo "/home/username/local"
	echo "this must be absolute path"
	exit 1
fi

# set bin path and lib path to use newest gcc compiler
export PATH="$1/bin:$1/sbin:$1/libexec/gcc/x86_64-pc-linux-gnu/6.3.0:$PATH"
export LD_LIBRARY_PATH="$1/lib:$1/lib64:$LD_LIBRARY_PATH"

# download zlib
wget http://zlib.net/zlib-1.2.10.tar.gz
tar zxf zlib-1.2.10.tar.gz

# download openssl
wget https://www.openssl.org/source/openssl-1.1.0c.tar.gz
tar zxf openssl-1.1.0c.tar.gz

# build nginx
wget http://nginx.org/download/nginx-1.11.8.tar.gz
git clone https://github.com/agentzh/headers-more-nginx-module/
wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.40.tar.gz
tar zxf nginx-1.11.8.tar.gz
tar zxf pcre-8.40.tar.gz
cd nginx-1.11.8
./configure --prefix=$1  --with-openssl=../openssl-1.1.0c --add-module=../headers-more-nginx-module/ --with-pcre=../pcre-8.40 --with-zlib=../zlib-1.2.10  --with-http_ssl_module --with-http_v2_module
make -j32
make -j32 install
cd ../
rm -rf nginx-1.11.8* headers-more-nginx-module* pcre-8.40* *zlib-1.2.10* openssl-1.1.0c*
