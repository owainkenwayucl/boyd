export CUDA_HOME=/usr/local/cuda-12.3
export PATH=$CUDA_HOME/bin:$PATH
export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH

# FML https://x.com/owainkenway/status/1768295586938122399
export CPATH=$CUDA_HOME/include:$CPATH

echo ">>> CPATH IS ${CPATH} <<<"

export TMPDIR=/dev/shm

export torch_cuda_arch_list="8.0"
export NCCL_INCLUDE_DIR=/usr/include
export USE_DISTRIBUTED=1
export USE_CUDA=1
export USE_SYSTEM_NCCL=1
export USE_OPENTELEMETRY=0

