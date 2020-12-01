#!/bin/bash

# calling script needs to set:

# $base
# $src
# $trg
# $model_name
# $seed

data=$base/data

prepared=$base/prepared

models=$base/models
models_sub=$models/$model_name

mkdir -p $models_sub

source $base/venvs/sockeye3-gpu/bin/activate

# parameters are the same for all Transformer models

num_embed="512:512"
num_layers="6:6"
transformer_model_size="512"
transformer_attention_heads="8"
transformer_feed_forward_num_hidden="2048"
embed_dropout=0.1
transformer_dropout=0.1
batch_size=4096
decode_and_evaluate=2500
checkpoint_interval=2500

for unused in pseudo_loop; do

  # check if training is finished

  if [[ -f $models_sub/log ]]; then

      training_finished=`grep "Training finished" $models_sub/log | wc -l`

      if [[ $training_finished != 0 ]]; then
          echo "Training is finished"
          echo "Skipping. Delete files to repeat step."
          continue
      fi
  fi

  ##################################################

  python -m sockeye.train \
  -d $prepared \
  -vs $data/dev.bpe.$src \
  -vt $data/dev.bpe.$trg \
  --output $models_sub \
  --seed $seed \
  --batch-type word \
  --batch-size $batch_size \
  --device-ids 0 \
  --encoder transformer \
  --decoder transformer \
  --num-layers $num_layers \
  --transformer-model-size $transformer_model_size \
  --transformer-attention-heads $transformer_attention_heads \
  --transformer-feed-forward-num-hidden $transformer_feed_forward_num_hidden \
  --transformer-preprocess n \
  --transformer-postprocess dr \
  --transformer-dropout-attention $transformer_dropout \
  --transformer-dropout-act $transformer_dropout \
  --transformer-dropout-prepost $transformer_dropout \
  --transformer-positional-embedding-type fixed \
  --embed-dropout $embed_dropout:$embed_dropout \
  --weight-tying-type src_trg_softmax \
  --num-embed $num_embed \
  --num-words 64000:64000 \
  --optimizer adam \
  --initial-learning-rate 0.0001 \
  --learning-rate-reduce-num-not-improved 4 \
  --checkpoint-interval $checkpoint_interval \
  --keep-last-params 30 \
  --max-seq-len 100:100 \
  --learning-rate-reduce-factor 0.7 \
  --decode-and-evaluate $decode_and_evaluate \
  --max-num-checkpoint-not-improved 10 \
  --min-num-epochs 0 \
  --gradient-clipping-type abs \
  --gradient-clipping-threshold 1 \
  --decode-and-evaluate-device-id 0 \
  --disable-device-locking \
  --max-seconds 86400

done
