#!/bin/bash -l

set -e

repo=https://github.com/brentp/cyvcf2
version=v0.30.18
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
pip3 install --upgrade pip
# Dependencies for build
pip3 install ${deps}

git clone --recursive $repo
cd cyvcf2
git checkout $version
cd htslib
git submodule update --init --recursive
autoheader
autoconf
./configure --enable-libcurl
make

cd ..
export CYTHONIZE=1

python3 setup.py bdist_wheel 


mkdir -p ${loc}/wheels
cp dist/*.whl ${loc}/wheels

rm -rf $temp_dir




