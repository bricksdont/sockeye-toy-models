#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

mkdir -p $base/models

num_threads=6
model_name=model_europarl
devices=-4

##################################

OMP_NUM_THREADS=$num_threads python -m sockeye.train \
			-s $base/data/train.bpe.de \
			-t $base/data/train.bpe.en \
			-vs $base/data/dev.bpe.de \
      -vt $base/data/dev.bpe.en \
      --batch-type=word \
      --batch-size=4096 \
      --max-seq-len=80:80 \
      --encoder rnn \
      --decoder rnn \
      --num-embed 256 \
		  --num-layers 2:2 \
      --rnn-num-hidden 512 \
      --rnn-attention-type mlp \
      --embed-dropout=0.1:0.1 \
      --rnn-decoder-hidden-dropout=0.2 \
      --layer-normalization \
      --weight-tying \
      --weight-tying-type=src_trg_softmax \
      --label-smoothing 0.1 \
      --decode-and-evaluate 500 \
      --checkpoint-frequency=2000 \
      --max-num-checkpoint-not-improved=16 \
      --learning-rate-reduce-factor=0.7 \
      --initial-learning-rate=0.001 \
      --device-ids=$devices \
      --decode-and-evaluate-use-cpu \
       -o $base/models/$model_name
