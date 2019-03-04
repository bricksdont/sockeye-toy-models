#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

mkdir -p $base/models

num_threads=1
model_name=model_10k

##################################

OMP_NUM_THREADS=$num_threads python -m sockeye.train \
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
                        -o $base/models/$model_name \
			--max-updates 10000
