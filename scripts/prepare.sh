#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

data=$base/data
prepared=$base/prepared

source $base/venvs/sockeye3-cpu/bin/activate

# measure time

SECONDS=0

mkdir -p $prepared

src=en
trg=de

cmd="python -m sockeye.prepare_data -s $data/train.bpe.$src -t $data/train.bpe.$trg --shared-vocab -o $prepared"

echo "Executing:"
echo "$cmd"

python -m sockeye.prepare_data \
                        -s $data/train.bpe.$src \
                        -t $data/train.bpe.$trg \
			                  --shared-vocab \
                        -o $prepared

echo "time taken:"
echo "$SECONDS seconds"
