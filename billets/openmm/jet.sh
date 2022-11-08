#!/bin/bash -l
echo "IN TESTING"
set -e

source /etc/profile.d/modules.sh

repo=https://github.com/openmm/openmm
version=v${TARGET_VERSION:-7.7.0}
name=pdbfixer
loc=`pwd`
me=`whoami`

deps="numpy"
moduledeps="compilers/gnu/4.9.2 cuda/10.0.130/gnu-4.9.2 fftw/3.3.4-threads/gnu-4.9.2 flex/2.5.39 bison/3.0.4/gnu-4.9.2 ghostscript/9.19/gnu-4.9.2 texlive/2015 /3.0.5/gnu-4.9.2 qt/4.8.6/gnu-4.9.2 lua/5.3.1 require perl/5.22.0 graphviz/2.40.1 doxygen/1.8.14"

mkdir -p /dev/shm/${me}/${name}
temp_dir=`mktemp -d -p /dev/shm/${me}/${name}`

module load "${moduledeps}"

# Create build environment
cd $temp_dir
virtualenv build_venv
source build_venv/bin/activate
pip3 install --upgrade pip
# Dependencies for build
pip3 install ${deps}

git clone --recursive $repo
cd openmm
git checkout $version

mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX}

make 
make install
make PythonInstall



mkdir -p ${loc}/wheels
cp dist/*.whl ${loc}/wheels

rm -rf $temp_dir