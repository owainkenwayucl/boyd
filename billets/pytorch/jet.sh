#!/bin/bash -l

set -e

repo=https://github.com/pytorch/pytorch.git
nvversion=${TARGET_VERSION:-2.3.0}
version=v${nvversion}
name=pytorch
loc=`pwd`
me=`whoami`
export PYTORCH_BUILD_VERSION=${nvversion}

export PYTORCH_BUILD_NUMBER=1

deps="numpy"

if [ -e ${loc}/billets/${name}/${name}_local.sh ]
then
    source ${loc}/billets/${name}/${name}_local.sh
fi

mkdir -p /dev/shm/${me}/${name}
temp_dir=`mktemp -d -p /dev/shm/${me}/${name}`

# Create build environment
cd $temp_dir
virtualenv build_venv
source build_venv/bin/activate
pip3 install --upgrade pip

if [ -e ${loc}/billets/${name}/${name}_piplocal.sh ]
then
    source ${loc}/billets/${name}/${name}_piplocal.sh
fi


if [ ! -e ${loc}/pytorch_${version}.tar ]
then
    echo " >>> No archive found, downloading from Git. <<< "
    git clone --recursive $repo
    cd ${name}

    git checkout ${version}
    git submodule sync
    git submodule update --init --recursive
    rm -rf third_party/opentelemetry-cpp/ # Fix for opentelementary license errors - remove post 2.2.x
    cd ..
    tar -cf ${loc}/pytorch_${version}.tar ${name}
else
    echo " >>> Archive found. <<<"
    tar xf ${loc}/pytorch_${version}.tar
fi

cp ${loc}/billets/${name}/patches/*.patch .

patch pytorch/aten/src/ATen/native/cuda/LinearAlgebra.cu < aten.patch
patch pytorch/aten/src/ATen/native/sparse/cuda/cuSPARSELtOps.cpp < aten2.patch

cd ${name}

# Dependencies for build
pip3 install -r requirements.txt
pip3 install ${deps}

python3 setup.py bdist_wheel 


mkdir -p ${loc}/wheels
cp dist/*.whl ${loc}/wheels

rm -rf $temp_dir
