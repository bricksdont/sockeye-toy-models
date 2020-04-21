#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

tools=$base/tools
mkdir -p $tools

# CUDA version on instance
CUDA_VERSION=100

# checkout repo

git clone https://github.com/ZurichNLP/sockeye $tools/sockeye

(cd $tools/sockeye && git checkout debug_init)

# GPU

source $base/venvs/sockeye3-gpu/bin/activate

pip install --no-deps -r $tools/sockeye/requirements/requirements.gpu-cu${CUDA_VERSION}.txt $tools/sockeye

# CPU

deactivate
source $base/venvs/sockeye3-cpu/bin/activate

pip install --no-deps -r $tools/sockeye/requirements/requirements.txt $tools/sockeye
