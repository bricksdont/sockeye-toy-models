#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

data=$base/data

mkdir -p $data

source $base/venvs/sockeye3-cpu/bin/activate

sockeye-autopilot --task wmt14_en_de --model none --workspace $data/sockeye_autopilot
