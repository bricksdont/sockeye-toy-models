#! /bin/bash

# calling script needs to set:
# $base
# $src
# $trg

# measure time

SECONDS=0

data=$base/data
prepared=$base/prepared

mkdir -p $prepared

source $base/venvs/sockeye3-cpu/bin/activate

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
