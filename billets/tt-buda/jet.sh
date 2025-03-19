#!/bin/bash -l

set -e

repo=https://github.com/tenstorrent/tt-buda.git
version=v${TARGET_VERSION:-0.19.3}
name=tt-buda
loc=`pwd`
me=`whoami`

#deps=""

mkdir -p /dev/shm/${me}/${name}
temp_dir=`mktemp -d -p /dev/shm/${me}/${name}`

# Create build environment
cd $temp_dir
python3.9 -m venv build_venv
source build_venv/bin/activate
pip3 install --upgrade pip wheel setuptools
# Dependencies for build
#pip3 install ${deps}

git clone --recursive $repo
cd ${name}
git checkout $version
git submodule sync
git submodule update --init --recursive

export BACKEND_ARCH_NAME=wormhole_b0
python3 setup.py bdist_wheel 


mkdir -p ${loc}/wheels
cp dist/*.whl ${loc}/wheels

rm -rf $temp_dir




