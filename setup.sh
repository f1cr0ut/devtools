#!/bin/bash

if [ $# -ne 1 ]; then
	echo "input prefix dir without last / like:"
	echo "/home/username/local"
	echo "this must be absolute path"
	exit 1
fi

# build glibc
# glibc need gawk. install it manually.
wget http://ftp.gnu.org/gnu/glibc/glibc-2.24.tar.gz
tar zxf glibc-2.24.tar.gz
cd glibc-2.24
mkdir build
cd build
../configure --prefix=$1
make -j32
make -j32 install
cd ../../
rm -rf glibc-2.24*

# build gcc
wget http://mirrors-usa.go-parts.com/gcc/releases/gcc-6.3.0/gcc-6.3.0.tar.gz
tar zxf gcc-6.3.0.tar.gz
cd gcc-6.3.0
./contrib/download_prerequisites
mkdir build
cd build
../configure --prefix=$1 --libdir=$1/lib -enable-languages=c,c++ --disable-bootstrap --disable-multilib
make -j32
make -j32 install
cd ../../
rm -rf gcc-6.3.0*

# set bin path and lib path to use newest gcc compiler
export PATH="$1/bin:$1/libexec/gcc/x86_64-pc-linux-gnu/6.3.0:$PATH"
export LD_LIBRARY_PATH="$1/lib:$1/lib64:$LD_LIBRARY_PATH"

# build gdbm
# this library is for ruby
wget ftp://ftp.gnu.org/gnu/gdbm/gdbm-1.12.tar.gz
tar zxf gdbm-1.12.tar.gz
cd gdbm-1.12
./configure --prefix=$1
make -j32
make -j32 install
cd ../
rm -rf gdbm-1.12*

# build readline 
# this library is for ruby
wget http://git.savannah.gnu.org/cgit/readline.git/snapshot/readline-master.tar.gz
tar zxf readline-master.tar.gz
cd readline-master
./configure --prefix=$1
make -j32
make -j32 install
cd ../
rm -rf readline-master*

# build sqlite3
# this library is for python
wget https://sqlite.org/2017/sqlite-autoconf-3160200.tar.gz
tar zxf sqlite-autoconf-3160200.tar.gz
cd sqlite-autoconf-3160200
./configure --prefix=$1
make -j32
make -j32 install
cd ../
rm -rf sqlite-autoconf-3160200*

# build bz2
# this library is for python
wget http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz
tar zxf bzip2-1.0.6.tar.gz
cd bzip2-1.0.6
make -j32
make install PREFIX=$1
cd ../
rm -rf bzip2-1.0.6*

# build zlib
wget http://zlib.net/zlib-1.2.11.tar.gz
tar zxf zlib-1.2.11.tar.gz
cd zlib-1.2.11
./configure --prefix=$1
make -j32
make -j32 install
cd ../
rm -rf zlib-1.2.11*

# build openssl
wget https://www.openssl.org/source/openssl-1.1.0c.tar.gz
tar zxf openssl-1.1.0c.tar.gz
cd openssl-1.1.0c
./config shared zlib --prefix=$1 -I$1/include -L$1/lib -L$1/lib64
make -j32
make -j32 install
cd ..
rm -rf openssl-1.1.0c*

# build ruby
wget https://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.0.tar.gz
tar zxf ruby-2.4.0.tar.gz
cd ruby-2.4.0
./configure --prefix=$1 CFLAGS=-I$1/include LDFLAGS="-L$1/lib -L$1/lib64"
make -j32
make -j32 install
cd ..
rm -rf ruby-2.4.0*

# build python
wget https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tgz
tar zxf Python-3.6.0.tgz
cd Python-3.6.0
./configure --prefix=$1 CFLAGS=-I$1/include LDFLAGS="-L$1/lib -L$1/lib64"
make -j32
make -j32 install
cd ..
rm -rf Python-3.6.0*
