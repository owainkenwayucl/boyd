#!/bin/bash -l

set -e

repo=https://github.com/openmm/pdbfixer
version=v${TARGET_VERSION:-1.8.1}
name=pdbfixer
loc=`pwd`
me=`whoami`

deps=""

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
cd pdbfixer

python3 setup.py bdist_wheel 


mkdir -p ${loc}/wheels
cp dist/*.whl ${loc}/wheels

rm -rf $temp_dir