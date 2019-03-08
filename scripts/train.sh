#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

mkdir -p $base/models

threads=2
model_name=model_continue

OMP_NUM_THREADS=$threads python -m sockeye.train \
                        -s $base/data/train.bpe.de \
                        -t $base/data/train.bpe.en \
                        -vs $base/data/dev.bpe.de \
                        -vt $base/data/dev.bpe.en \
                        --encoder rnn \
                        --decoder rnn \
                        --num-embed 256 \
                        --num-layers 1:1 \
                        --checkpoint-frequency 100 \
                        --rnn-num-hidden 512 \
                        --rnn-attention-type dot \
                        --max-seq-len 80 \
                        --decode-and-evaluate 500 \
                        --use-cpu \
                        -o $base/models/$model_name \
                        --params $base/params.best \
                        --max-updates 150
