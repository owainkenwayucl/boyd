#!/bin/bash -l

set -e

name=cyvcf2
loc=`pwd`
me=`whoami`

deps="numpy Cython"

mkdir -p /dev/shm/${me}/${name}
temp_dir=`mktemp -d -p /dev/shm/${me}/${name}`

# Create build environment
cd $temp_dir
virtualenv build_venv
source build_venv/bin/activate

# Dependencies for build
pip3 install ${deps}

filename=$(pip3 download --no-binary :all: --no-deps $name | grep Saved | awk '{print $2}')
IFS='/' read -ra dir_tmp <<< "$(tar zxvf ${filename} | tail -n 1)"
cd ${dir_tmp[0]}

cd htslib
autoheader
autoconf
./configure --enable-libcurl
make

cd ..

python3 setup.py sdist bdist_wheel

mkdir -p ${loc}/wheels
cp dist/*.whl ${loc}/wheels

rm -rf $temp_dir




