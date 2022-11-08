#!/bin/bash -l

set -e

repo=https://github.com/brentp/cyvcf2
version=v0.11.5
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

git clone --recursive $repo
cd cyvcf2
cd htslib
autoheader
autoconf
./configure --enable-libcurl
make

cd ..

export CYTHNONIZE=1 

python3 setup.py install sdist bdist_wheel

mkdir -p ${loc}/wheels
cp dist/*.whl ${loc}/wheels

rm -rf $temp_dir




