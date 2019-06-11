#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

tools=$base/tools
mkdir -p $tools

echo "Make sure this script is executed AFTER you have activated a virtualenv"

# install Sockeye

git clone https://github.com/bricksdont/sockeye $tools/sockeye
(cd $tools/sockeye && git checkout reconstruction)
(cd $tools/sockeye && git pull)

# CUDA version on rattle
CUDA_VERSION=80

pip install --upgrade --no-deps -r $tools/sockeye/requirements/requirements.gpu-cu${CUDA_VERSION}.txt $tools/sockeye
