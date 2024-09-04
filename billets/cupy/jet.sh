#!/bin/bash -l

set -e

repo=https://github.com/cupy/cupy.git
nvversion=${TARGET_VERSION:-2.3.0}
version=v${nvversion}
name=cupy
loc=`pwd`
me=`whoami`

deps="wheel"

if [ -e ${loc}/billets/${name}/${name}_local.sh ]
then
    source ${loc}/billets/${name}/${name}_local.sh
fi

mkdir -p /dev/shm/${me}/${name}
temp_dir=`mktemp -d -p /dev/shm/${me}/${name}`

# Create build environment
cd $temp_dir
python3 -m venv build_venv
source build_venv/bin/activate
pip3 install --upgrade pip

if [ -e ${loc}/billets/${name}/${name}_piplocal.sh ]
then
    source ${loc}/billets/${name}/${name}_piplocal.sh
fi


if [ ! -e ${loc}/${name}_${version}.tar ]
then
    echo " >>> No archive found, downloading from Git. <<< "
    git clone --recursive $repo
    cd ${name}

    git checkout ${version}
    cd ..
    tar -cf ${loc}/${name}_${version}.tar ${name}
else
    echo " >>> Archive found. <<<"
    tar xf ${loc}/${name}_${version}.tar
fi

cp ${loc}/billets/${name}/patches/*.patch .

cd ${name}

export CUPY_INSTALL_USE_HIP=1

# Patch for ROCm 6+
patch cupy_backends/cuda/api/runtime.pyx runtime.pyx.patch
patch cupy_backends/hip/cupy_hip_runtime.h cupy_hip_runtime.h.patch
path cupy_backends/cuda/api/_runtime_typedef.pxi _runtime_typedef.pxi.patch

# Dependencies for build
python3 setup.py bdist_wheel 


mkdir -p ${loc}/wheels
cp dist/*.whl ${loc}/wheels

rm -rf $temp_dir
