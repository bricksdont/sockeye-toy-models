#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

tools=$base/tools
mkdir -p $tools

echo "Make sure this script is executed AFTER you have activated a virtualenv"

# install Sockeye

git clone https://github.com/bricksdont/sockeye $tools/sockeye
(cd $tools/sockeye && git checkout reconstruction)

# CUDA version on rattle
CUDA_VERSION=80

pip install --no-deps -r $tools/sockeye/requirements.gpu-cu${CUDA_VERSION}.txt .

pip install matplotlib mxboard

# install BPE library

pip install subword-nmt

# install sacrebleu for evaluation

pip install sacrebleu

# install Moses scripts for preprocessing

git clone https://github.com/bricksdont/moses-scripts $tools/moses-scripts

