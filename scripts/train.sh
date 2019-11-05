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
                        --encoder transformer \
                        --decoder transformer \
                        --num-embed 512 \
			--num-layers 6:6 \
			--checkpoint-frequency 1000 \
                        --rnn-num-hidden 512 \
                        --rnn-attention-type dot \
                        --max-seq-len 100 \
                        --decode-and-evaluate 500 \
                        --device-ids 0 \
                        -o $base/models/$model_name
