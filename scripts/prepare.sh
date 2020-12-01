#! /bin/bash

# calling script needs to set:
# $base
# $src
# $trg

# measure time

SECONDS=0

data=$base/data
prepared=$base/prepared

for unused in pseudo_loop; do

    if [[ -d $prepared ]]; then
      echo "Folder exists: $prepared"
      echo "Skipping. Delete folder to repeat step."
      continue
    fi

    mkdir -p $prepared

    source $base/venvs/sockeye3-cpu/bin/activate

    cmd="python -m sockeye.prepare_data -s $data/train.bpe.$src -t $data/train.bpe.$trg --shared-vocab -o $prepared --max-seq-len 100:100"

    echo "Executing:"
    echo "$cmd"

    python -m sockeye.prepare_data \
                            -s $data/train.bpe.$src \
                            -t $data/train.bpe.$trg \
                            --shared-vocab \
                            -o $prepared \
                            --max-seq-len 100:100

    echo "time taken:"
    echo "$SECONDS seconds"

done
