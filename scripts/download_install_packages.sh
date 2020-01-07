#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

tools=$base/tools
mkdir -p $tools


if [[ `hostname` == 'login0' ]]; then
  # S3IT
  source /net/cephfs/home/mathmu/scratch/goeckeritz-model/venvs/sockeye3/bin/activate
  module use /sapps/etc/modules/start/
  module load volta cuda/10.0
else
  # CSD3
  source /rds/project/t2_vol4/rds-t2-cs037/mmueller/domain-robustness/venvs/sockeye3/bin/activate
  module purge
  module load rhel7/default-peta4
  module load volta cuda/10.0
  module add python-3.6.2-gcc-5.4.0-me5fsee
fi;

# install Sockeye

# CUDA version on instance
CUDA_VERSION=100

## Method A: install from PyPi

wget https://raw.githubusercontent.com/awslabs/sockeye/master/requirements/requirements.gpu-cu${CUDA_VERSION}.txt
pip install sockeye --no-deps -r requirements.gpu-cu${CUDA_VERSION}.txt
rm requirements.gpu-cu${CUDA_VERSION}.txt

pip install matplotlib mxboard

# install BPE library

pip install subword-nmt

# install sacrebleu for evaluation

pip install sacrebleu

# install Moses scripts for preprocessing

git clone https://github.com/bricksdont/moses-scripts $tools/moses-scripts
