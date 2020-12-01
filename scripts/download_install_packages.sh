#! /bin/bash

# calling script needs to set:
# $base

export TMPDIR="/var/tmp"

tools=$base/tools
mkdir -p $tools

# install Moses scripts for preprocessing

git clone https://github.com/bricksdont/moses-scripts $tools/moses-scripts

# CUDA version on instance
CUDA_VERSION=102

# GPU

source $base/venvs/sockeye3-gpu/bin/activate

## Method A: install from PyPi

wget https://raw.githubusercontent.com/awslabs/sockeye/master/requirements/requirements.gpu-cu${CUDA_VERSION}.txt
pip install sockeye --no-deps -r requirements.gpu-cu${CUDA_VERSION}.txt
rm requirements.gpu-cu${CUDA_VERSION}.txt

pip install mxboard tensorboard

# CPU

deactivate
source $base/venvs/sockeye3-cpu/bin/activate

wget https://raw.githubusercontent.com/awslabs/sockeye/master/requirements/requirements.txt
pip install --no-deps -r requirements/requirements.txt $tools/sockeye
rm requirements.txt

pip install mxboard tensorboard

# CPU 2 (for autopilot only)

deactivate
source $base/venvs/sockeye-autopilot/bin/activate

pip install sockeye==1.18.115

# download paired bootstrap

wget https://raw.githubusercontent.com/bricksdont/util-scripts/master/paired-bootstrap.py
mv paired-bootstrap.py $tools/paired-bootstrap.py
