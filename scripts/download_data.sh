#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

data=$base/data

src=en
trg=de

mkdir -p $data

source $base/venvs/sockeye3-cpu/bin/activate

sockeye-autopilot --task wmt14_en_de --model none --workspace $data/sockeye_autopilot

(cd $data/sockeye_autopilot/systems/wmt14_en_de/data/bpe && gunzip *)

for corpus in train dev test; do
  for lang in $src $trg; do
    ln -snf $data/sockeye_autopilot/systems/wmt14_en_de/data/bpe/$corpus.bpe.$lang $data/$corpus.bpe.$lang
  done
done
