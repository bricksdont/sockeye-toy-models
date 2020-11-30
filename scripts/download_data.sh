#! /bin/bash

# calling script needs to set:
# $base
# $src
# $trg

data=$base/data

mkdir -p $data

source $base/venvs/sockeye-autopilot/bin/activate

sockeye-autopilot --task wmt14_en_de --model none --workspace $data/sockeye_autopilot

(cd $data/sockeye_autopilot/systems/wmt14_en_de/data/bpe && gunzip *)

ln -snf $data/sockeye_autopilot/systems/wmt14_en_de/data/bpe/train.src $data/train.bpe.$src
ln -snf $data/sockeye_autopilot/systems/wmt14_en_de/data/bpe/train.trg $data/train.bpe.$trg

ln -snf $data/sockeye_autopilot/systems/wmt14_en_de/data/bpe/dev.src $data/dev.bpe.$src
ln -snf $data/sockeye_autopilot/systems/wmt14_en_de/data/bpe/dev.trg $data/dev.bpe.$trg

ln -snf $data/sockeye_autopilot/systems/wmt14_en_de/data/bpe/test.0.src $data/test.bpe.$src
ln -snf $data/sockeye_autopilot/systems/wmt14_en_de/data/bpe/test.0.trg $data/test.bpe.$trg

# sizes
echo "Sizes of corpora:"
wc -l $data/*

# sanity checks
echo "At this point, please make sure that 1) number of lines are as expected, 2) language suffixes are correct and 3) files are parallel"
