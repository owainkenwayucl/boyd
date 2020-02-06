#!/bin/bash -l

set -e

repo=https://github.com/brentp/cyvcf2
version=v0.11.5
name=cyvcf2
loc=`pwd`

mkdir -p /dev/shm/`whoami`/${name}
temp_dir=`mkdir -d -p /dev/shm/`whoami`/${name}`

# Create build environment
cd $temp_dir
virtualenv build_venv
source build_venv/bin/activate

# Dependencies for build
pip3 install numpy Cython

git clone --recursive $repo
cd cyvcf2

python3 setup.py sdist bdist_wheel

mkdir -p ${loc}/wheels
cp dist/*.whl ${loc}/wheels

rm -rf $temp_dir




