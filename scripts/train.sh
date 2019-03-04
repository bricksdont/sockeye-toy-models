#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

mkdir -p $base/models

python -m sockeye.train \
			-s $base/data/train.bpe.de \
			-t $base/data/train.bpe.en \
			-vs $base/data/dev.bpe.de \
                        -vt $base/data/dev.bpe.en \
                        --encoder rnn \
                        --decoder rnn \
                        --num-embed 64 \
			--num-layers 1:1 \
			--checkpoint-frequency 500 \
                        --rnn-num-hidden 128 \
                        --rnn-attention-type dot \
                        --max-seq-len 60 \
                        --decode-and-evaluate 500 \
                        --use-cpu \
                        -o $base/models/model_10k \
			--max-updates 1000
