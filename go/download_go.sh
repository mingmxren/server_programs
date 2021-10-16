#!/bin/sh
set -ex

cd $(dirname "$(readlink -f "$0")")


dirname="go"

targz_filename="go1.17.2.linux-amd64.tar.gz"
targz_md5sum="b7af894763e397335efe5a9ca70a5d63"
url="https://golang.org/dl/$targz_filename"

mkdir -p data
cd data

# 检查是否已经安装
if [ -d $dirname ] ; then
	echo "$dirname already installed"
	exit 0
fi

# 下载文件
if [ ! -e $targz_filename ] ; then
	curl -L $url -o $targz_filename
fi
local_md5sum="$(md5sum $targz_filename | awk '{print $1}')"
if [ "$local_md5sum" != "$targz_md5sum" ] ; then
	echo " $targz_filename local md5sum($local_md5sum) != $targz_md5sum"
	exit 1
fi

# 解包
tar xf $targz_filename

# 检查文件夹是否存在
if [ ! -d $dirname ] ; then
	echo "$dirname not found after download and tar xf"
	exit 1
fi

