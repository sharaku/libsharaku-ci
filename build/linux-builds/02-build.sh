#!/bin/sh
# ----------------------------------------------------------------------------
#
#  MIT License
#  
#  Copyright (c) 2017 Abe Takafumi
#  
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#  
#  The above copyright notice and this permission notice shall be included in all
#  copies or substantial portions of the Software.
#  
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#  SOFTWARE. *
#
# ----------------------------------------------------------------------------

cd `dirname $0`
readonly OBJ_PATH=`pwd`
readonly DEF_LOGPATH=${OBJ_PATH}/result
readonly BASE_PATH=${OBJ_PATH}/../../

mkdir -p ./result

# lib ビルドを行う
#  arg1		ビルド対象
#  arg2		ビルドターゲット{linux-x86}
do_lib_build()
{
	lib_path=$1
	build_target=$2
	lib_name=`basename ${lib_path}`

	cd ${lib_path}
	rm -f CMakeCache.txt cmake_install.cmake rm Makefile
	rm -rf CMakeFiles
	cmake -DCMAKE_TOOLCHAIN_FILE=${BASE_PATH}cmake/${build_target}.cmake
	make clean
	make 2>&1 | tee ${DEF_LOGPATH}/make.${lib_name}.${build_target}
}

# libをビルド
do_lib_build ${BASE_PATH}libs/container linux-x86
do_lib_build ${BASE_PATH}libs/atomic linux-x86
do_lib_build ${BASE_PATH}libs/pool linux-x86
do_lib_build ${BASE_PATH}libs/type linux-x86
do_lib_build ${BASE_PATH}libs/lock linux-x86
do_lib_build ${BASE_PATH}libs/debug linux-x86
