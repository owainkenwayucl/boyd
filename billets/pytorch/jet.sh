#!/bin/bash -l

set -e

repo=https://github.com/pytorch/pytorch.git
version=v${TARGET_VERSION:-2.2.0}
name=pytorch
loc=`pwd`
me=`whoami`

deps="numpy"

mkdir -p /dev/shm/${me}/${name}
temp_dir=`mktemp -d -p /dev/shm/${me}/${name}`

# Create build environment
cd $temp_dir
virtualenv build_venv
source build_venv/bin/activate
pip3 install --upgrade pip

if [ ! -e ${loc}/pytorch_${version}.tar ]
then
    echo " >>> No archive found, downloading from Git. <<< "
    git clone --recursive $repo
    cd ${name}

    git checkout ${version}
    git submodule sync
    git submodule update --init --recursive
    cd ..
    tar -cf ${loc}/pytorch_${version}.tar ${name}
else
    echo " >>> Archive found. <<<"
    tar xvf ${loc}/pytorch_${version}.tar
fi

cd ${name}

# Dependencies for build
pip3 install -r requirements.txt
pip3 install ${deps}

python3 setup.py bdist_wheel 


mkdir -p ${loc}/wheels
cp dist/*.whl ${loc}/wheels

rm -rf $temp_dir