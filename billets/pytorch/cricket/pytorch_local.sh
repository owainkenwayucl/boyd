source ~/cuda12.3.sh

echo ">>> CPATH IS ${CPATH} <<<"

export TMPDIR=/dev/shm

#export CUDAARCHS="52;60;61;70;72;75;80;86;87;90"

#export TORCH_CUDA_ARCH_LIST="5.2 6.0 6.2 7.0 7.2 7.5 8.0 8.6 8.7 9.0"
#export torch_cuda_arch_list="5.2 6.0 6.2 7.0 7.2 7.5 8.0 8.6 8.7 9.0+ptx"
export torch_cuda_arch_list="8.0"
#export LD_LIBRARY_PATH=/home/uccaoke/Applications/magma-2.7.2/lib:$LD_LIBRARY_PATH
#export CPATH=/home/uccaoke/Applications/magma-2.7.2/include:$CPATH
#export PKG_CONFIG_PATH=/home/uccaoke/Applications/magma-2.7.2/lib/pkgconfig:$PKG_CONFIG_PATH
#export MAGMA_HOME=/home/uccaoke/Applications/magma-2.7.2

#export PATH=/usr/lib64/openmpi/bin:$PATH
#export LD_LIBRARY_PATH=/usr/lib64/openmpi/lib:$LD_LIBRARY_PATH
#export CPATH=/usr/lib64/openmpi/include:$CPATH

#tensort_dir=/home/uccaoke/Applications/TensorRT-8.6.1.6
#
#export LD_LIBRARY_PATH=${tensort_dir}/lib:${LD_LIBRARY_PATH}
#export PATH=${tensort_dir}/bin:${PATH}
#export CPATH=${tensort_dir}/include:${CPATH}
#export TENSORRT_ROOT=${tensort_dir}

export NCCL_INCLUDE_DIR=/usr/include
#export TENSORRT_INCLUDE_DIR=${tensort_dir}/include
#export TENSORRT_LIBRARY=${tensort_dir}/lib/libnvinfer.so

#ls $TENSORRT_LIBRARY

export USE_DISTRIBUTED=1
export USE_CUDA=1
#export USE_MPI=1
#export USE_MAGMA=1
export USE_SYSTEM_NCCL=1
export USE_OPENTELEMETRY=0
#export USE_TENSORRT=1
#export BUILD_CAFFE2=1

#export MPI_HOME=/usr/mpi/gcc/openmpi-4.1.7a1
#export PATH=${MPI_HOME}/bin:${PATH}
#export LD_LIBRARY_PATH=${MPI_HOME}/lib:${LD_LIBRARY_PATH}

