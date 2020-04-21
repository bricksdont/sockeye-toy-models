#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

data=$(readlink -m $base/data)

src=en
trg=de

mkdir -p $data

source $base/venvs/sockeye3-cpu/bin/activate

sockeye-autopilot --task wmt14_en_de --model none --workspace $data/sockeye_autopilot

(cd $data/sockeye_autopilot/systems/wmt14_en_de/data/bpe && gunzip *)

# smaller training data

train_size=500000

head -n $train_size $data/sockeye_autopilot/systems/wmt14_en_de/data/bpe/train.src > $data/train.bpe.$src
head -n $train_size $data/sockeye_autopilot/systems/wmt14_en_de/data/bpe/train.trg > $data/train.bpe.$trg

ln -snf $data/sockeye_autopilot/systems/wmt14_en_de/data/bpe/dev.src $data/dev.bpe.$src
ln -snf $data/sockeye_autopilot/systems/wmt14_en_de/data/bpe/dev.trg $data/dev.bpe.$trg

ln -snf $data/sockeye_autopilot/systems/wmt14_en_de/data/bpe/test.0.src $data/test.bpe.$src
ln -snf $data/sockeye_autopilot/systems/wmt14_en_de/data/bpe/test.0.trg $data/test.bpe.$trg
