#!/bin/sh
set -ex

cd $(dirname "$(readlink -f "$0")")


dirname="go"

targz_filename="go1.17.5.linux-amd64.tar.gz"
url="https://mirrors.ustc.edu.cn/golang/$targz_filename"
targz_sha256sum=$(curl $url.sha256)

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
local_sha256sum="$(sha256sum $targz_filename | awk '{print $1}')"
if [ "$local_md5sum" != "$targz_md5sum" ] ; then
	echo " $targz_filename local md5sum($local_md5sum) != $targz_sha256sum"
	exit 1
fi

# 解包
tar xf $targz_filename

# 检查文件夹是否存在
if [ ! -d $dirname ] ; then
	echo "$dirname not found after download and tar xf"
	exit 1
fi

