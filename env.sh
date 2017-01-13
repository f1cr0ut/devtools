#!/bin/bash
if [ $# -ne 1 ]; then
	echo "input prefix dir without last / like:"
	echo "/home/username/local"
	exit 1
fi

# set bin path and lib path to use newest gcc compiler
export PATH="$1/bin:$1/libexec/gcc/x86_64-pc-linux-gnu/6.3.0:$PATH"
export LD_LIBRARY_PATH="$1/lib:$1/lib64:$LD_LIBRARY_PATH"

