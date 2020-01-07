#! /bin/bash

data=$base/data
scripts=$base/scripts

translations=$base/translations

src=en
trg=de

mkdir -p $translations
mkdir -p $translations/$model_name

MOSES=$base/tools/moses-scripts/scripts

if [[ "$CUDA_VISIBLE_DEVICES" == "NoDevFiles" ]]; then
  num_threads=64
  device_arg="--use-cpu"
else
  num_threads=3
  device_arg="--device-ids 0"
fi

for corpus in $corpora; do
    OMP_NUM_THREADS=$num_threads python -m sockeye.translate \
            -i $data/$corpus.$src \
            -o $translations/$model_name/$corpus.bpe.$model_name.$trg \
            -m $model_paths \
            --beam-size 10 \
            --length-penalty-alpha 1.0 \
            $device_arg \
            --batch-size $batch_size \
            --disable-device-locking

    # undo BPE

    cat $translations/$model_name/$corpus.bpe.$model_name.$trg | sed -r 's/@@( |$)//g' > $translations/$model_name/$corpus.tokenized.$model_name.$trg

    # undo tokenization

    cat $translations/$model_name/$corpus.tokenized.$model_name.$trg | $MOSES/tokenizer/detokenizer.perl -l $trg > $translations/$model_name/$corpus.$model_name.$trg

done
