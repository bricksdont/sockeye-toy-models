#! /bin/bash

# check if calling script has set $base
if [ $# -eq 0 ]; then
  script_dir=`dirname "$0"`
  base=$script_dir/../..
else
  base=$1
fi;

mkdir -p $base/models

num_threads=1
model_name=baseline_4

##################################

OMP_NUM_THREADS=$num_threads python -m sockeye.train \
      -o $base/models/$model_name  \
      -d $base/data/prepared \
      -vs $base/data/dev.en \
      -vt $base/data/dev.de \
      --seed=4 \
      --batch-type=word \
      --batch-size=4096 \
      --checkpoint-frequency=4000 \
      --device-ids=0 \
      --decode-and-evaluate-device-id 0 \
      --embed-dropout=0:0 \
      --encoder=transformer \
      --decoder=transformer \
      --num-layers=6:6 \
      --transformer-model-size=512 \
      --transformer-attention-heads=8 \
      --transformer-feed-forward-num-hidden=2048 \
      --transformer-preprocess=n \
      --transformer-postprocess=dr \
      --transformer-dropout-attention=0.1 \
      --transformer-dropout-act=0.1 \
      --transformer-dropout-prepost=0.1 \
      --transformer-positional-embedding-type fixed \
      --max-seq-len=100:100 \
      --label-smoothing 0.1 \
      --weight-tying \
      --weight-tying-type=src_trg_softmax \
      --num-embed 512:512 \
      --num-words 50000:50000 \
      --word-min-count 1:1 \
      --optimizer=adam \
      --optimized-metric=perplexity \
      --initial-learning-rate=0.0001 \
      --learning-rate-reduce-num-not-improved=8 \
      --learning-rate-reduce-factor=0.7 \
      --learning-rate-scheduler-type=plateau-reduce \
      --learning-rate-warmup=0 \
      --max-num-checkpoint-not-improved=32 \
      --min-num-epochs=0 \
      --max-updates 10010000 \
      --weight-init xavier \
      --weight-init-scale 3.0 \
      --weight-init-xavier-factor-type avg \
      --disable-device-locking
